"""자율 에이전트 핵심 클래스"""
from typing import Any, Dict, List, Optional
import json
from datetime import datetime
from .tools import ToolRegistry, Tool


class Agent:
    """자율 작업 수행 에이전트"""
    
    def __init__(self, name: str = "Agent", max_iterations: int = 20):
        self.name = name
        self.tool_registry = ToolRegistry()
        self.max_iterations = max_iterations
        self.history: List[Dict[str, Any]] = []
        self.workspace_path = "/workspace"
    
    def plan(self, goal: str) -> List[str]:
        """목표를 단계별 계획으로 나눔"""
        # 간단한 계획 생성 로직
        # 실제로는 LLM을 사용하여 더 정교한 계획을 만들 수 있음
        steps = []
        
        goal_lower = goal.lower()
        
        # 파일 관련 작업
        if "읽" in goal or "read" in goal_lower:
            steps.append("파일 경로 확인")
            steps.append("파일 읽기")
        
        if "쓰" in goal or "write" in goal_lower or "생성" in goal or "만들" in goal:
            steps.append("파일 경로 확인")
            steps.append("파일 내용 생성")
            steps.append("파일 쓰기")
        
        # SQL 관련 작업
        if "sql" in goal_lower or "쿼리" in goal or "데이터베이스" in goal:
            steps.append("데이터베이스 경로 확인")
            steps.append("SQL 쿼리 작성")
            steps.append("SQL 실행")
        
        # 검색 관련 작업
        if "찾" in goal or "search" in goal_lower or "검색" in goal:
            steps.append("검색 패턴 확인")
            steps.append("파일 검색 실행")
        
        # 디렉토리 관련 작업
        if "목록" in goal or "list" in goal_lower or "파일" in goal:
            steps.append("디렉토리 목록 조회")
        
        if not steps:
            steps = ["목표 분석", "작업 수행", "결과 확인"]
        
        return steps
    
    def execute_tool(self, tool_name: str, **kwargs) -> Dict[str, Any]:
        """도구 실행"""
        tool = self.tool_registry.get(tool_name)
        if not tool:
            return {
                "success": False,
                "error": f"도구를 찾을 수 없습니다: {tool_name}"
            }
        
        try:
            result = tool.execute(**kwargs)
            return result
        except Exception as e:
            return {
                "success": False,
                "error": f"도구 실행 중 오류: {str(e)}"
            }
    
    def decide_action(self, goal: str, current_step: str, context: Dict[str, Any]) -> Dict[str, Any]:
        """현재 상황에서 다음 행동 결정"""
        # 간단한 규칙 기반 의사결정
        # 실제로는 LLM을 사용하여 더 지능적인 결정을 할 수 있음
        
        goal_lower = goal.lower()
        step_lower = current_step.lower()
        
        # 파일 읽기
        if "파일 읽기" in current_step or "read" in step_lower:
            # context에서 파일 경로 추출 시도
            file_path = context.get("file_path")
            if not file_path:
                # 목표에서 파일 경로 추출 시도
                import re
                match = re.search(r'["\']([^"\']+\.(sql|txt|py|md|json))["\']', goal)
                if match:
                    file_path = match.group(1)
                else:
                    return {
                        "action": "ask",
                        "message": "파일 경로가 필요합니다."
                    }
            
            return {
                "action": "execute_tool",
                "tool": "read_file",
                "params": {"file_path": file_path}
            }
        
        # 파일 쓰기
        if "파일 쓰기" in current_step or "write" in step_lower:
            file_path = context.get("file_path")
            content = context.get("content")
            
            if not file_path:
                return {
                    "action": "ask",
                    "message": "파일 경로가 필요합니다."
                }
            
            if not content:
                return {
                    "action": "ask",
                    "message": "파일 내용이 필요합니다."
                }
            
            return {
                "action": "execute_tool",
                "tool": "write_file",
                "params": {"file_path": file_path, "content": content}
            }
        
        # SQL 실행
        if "sql" in step_lower or "쿼리" in current_step:
            query = context.get("query")
            if not query:
                return {
                    "action": "ask",
                    "message": "SQL 쿼리가 필요합니다."
                }
            
            return {
                "action": "execute_tool",
                "tool": "execute_sql",
                "params": {"query": query}
            }
        
        # 디렉토리 목록
        if "목록" in current_step or "list" in step_lower:
            directory = context.get("directory", ".")
            return {
                "action": "execute_tool",
                "tool": "list_directory",
                "params": {"directory": directory}
            }
        
        # 검색
        if "검색" in current_step or "search" in step_lower:
            pattern = context.get("pattern")
            if not pattern:
                return {
                    "action": "ask",
                    "message": "검색 패턴이 필요합니다."
                }
            
            return {
                "action": "execute_tool",
                "tool": "search_files",
                "params": {"pattern": pattern}
            }
        
        # 기본: 도구 목록 조회
        return {
            "action": "list_tools"
        }
    
    def run(self, goal: str, context: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        """에이전트 실행"""
        if context is None:
            context = {}
        
        print(f"\n🤖 {self.name} 시작: {goal}\n")
        
        # 계획 수립
        plan = self.plan(goal)
        print(f"📋 계획: {' → '.join(plan)}\n")
        
        iteration = 0
        current_step_idx = 0
        
        while iteration < self.max_iterations and current_step_idx < len(plan):
            current_step = plan[current_step_idx]
            print(f"📍 단계 {current_step_idx + 1}/{len(plan)}: {current_step}")
            
            # 행동 결정
            action = self.decide_action(goal, current_step, context)
            
            # 행동 실행
            if action["action"] == "execute_tool":
                tool_name = action["tool"]
                params = action.get("params", {})
                
                print(f"  🔧 도구 실행: {tool_name}")
                if params:
                    print(f"     파라미터: {params}")
                
                result = self.execute_tool(tool_name, **params)
                
                # 결과를 context에 저장
                if result.get("success"):
                    context.update(result)
                    print(f"  ✅ 성공")
                    if "content" in result:
                        print(f"     내용 길이: {len(result['content'])} 문자")
                    if "results" in result:
                        print(f"     결과 수: {len(result['results'])}")
                else:
                    print(f"  ❌ 실패: {result.get('error', '알 수 없는 오류')}")
                
                # 히스토리에 기록
                self.history.append({
                    "iteration": iteration,
                    "step": current_step,
                    "action": action,
                    "result": result,
                    "timestamp": datetime.now().isoformat()
                })
                
                # 성공하면 다음 단계로
                if result.get("success"):
                    current_step_idx += 1
                else:
                    # 실패 시 재시도 또는 종료
                    print(f"  ⚠️  단계 실패, 계속 진행...")
                    current_step_idx += 1
            
            elif action["action"] == "list_tools":
                tools = self.tool_registry.list_tools()
                print(f"  📚 사용 가능한 도구: {len(tools)}개")
                for tool in tools:
                    print(f"     - {tool['name']}: {tool['description']}")
                current_step_idx += 1
            
            elif action["action"] == "ask":
                print(f"  ❓ {action['message']}")
                # 실제로는 사용자에게 물어봐야 하지만, 여기서는 건너뜀
                current_step_idx += 1
            
            iteration += 1
            print()
        
        # 최종 결과
        final_result = {
            "goal": goal,
            "success": current_step_idx >= len(plan),
            "iterations": iteration,
            "context": context,
            "history": self.history
        }
        
        if final_result["success"]:
            print(f"✅ 작업 완료!\n")
        else:
            print(f"⚠️  작업 중단 (최대 반복 횟수 도달 또는 오류)\n")
        
        return final_result
    
    def get_history(self) -> List[Dict[str, Any]]:
        """실행 히스토리 반환"""
        return self.history
    
    def clear_history(self):
        """히스토리 초기화"""
        self.history = []
