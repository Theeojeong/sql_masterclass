"""에이전트가 사용할 수 있는 도구들"""
import os
import subprocess
import sqlite3
from typing import Any, Dict, List, Optional
from pathlib import Path


class Tool:
    """기본 도구 클래스"""
    
    def __init__(self, name: str, description: str):
        self.name = name
        self.description = description
    
    def execute(self, **kwargs) -> Dict[str, Any]:
        """도구 실행"""
        raise NotImplementedError


class ReadFileTool(Tool):
    """파일 읽기 도구"""
    
    def __init__(self):
        super().__init__(
            name="read_file",
            description="파일의 내용을 읽습니다. 경로를 지정하세요."
        )
    
    def execute(self, file_path: str, **kwargs) -> Dict[str, Any]:
        try:
            path = Path(file_path)
            if not path.exists():
                return {
                    "success": False,
                    "error": f"파일을 찾을 수 없습니다: {file_path}"
                }
            
            with open(path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            return {
                "success": True,
                "content": content,
                "file_path": str(path)
            }
        except Exception as e:
            return {
                "success": False,
                "error": str(e)
            }


class WriteFileTool(Tool):
    """파일 쓰기 도구"""
    
    def __init__(self):
        super().__init__(
            name="write_file",
            description="파일에 내용을 씁니다. 파일이 없으면 생성합니다."
        )
    
    def execute(self, file_path: str, content: str, **kwargs) -> Dict[str, Any]:
        try:
            path = Path(file_path)
            path.parent.mkdir(parents=True, exist_ok=True)
            
            with open(path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            return {
                "success": True,
                "file_path": str(path),
                "message": "파일이 성공적으로 작성되었습니다."
            }
        except Exception as e:
            return {
                "success": False,
                "error": str(e)
            }


class ListDirectoryTool(Tool):
    """디렉토리 목록 조회 도구"""
    
    def __init__(self):
        super().__init__(
            name="list_directory",
            description="디렉토리의 파일과 폴더 목록을 조회합니다."
        )
    
    def execute(self, directory: str = ".", **kwargs) -> Dict[str, Any]:
        try:
            path = Path(directory)
            if not path.exists():
                return {
                    "success": False,
                    "error": f"디렉토리를 찾을 수 없습니다: {directory}"
                }
            
            items = []
            for item in path.iterdir():
                items.append({
                    "name": item.name,
                    "type": "directory" if item.is_dir() else "file",
                    "path": str(item)
                })
            
            return {
                "success": True,
                "items": items,
                "directory": str(path)
            }
        except Exception as e:
            return {
                "success": False,
                "error": str(e)
            }


class ExecuteSQLTool(Tool):
    """SQL 실행 도구"""
    
    def __init__(self, db_path: str = "SQLite/database.db"):
        super().__init__(
            name="execute_sql",
            description="SQLite 데이터베이스에 SQL 쿼리를 실행합니다."
        )
        self.db_path = db_path
    
    def execute(self, query: str, **kwargs) -> Dict[str, Any]:
        try:
            path = Path(self.db_path)
            if not path.exists():
                return {
                    "success": False,
                    "error": f"데이터베이스를 찾을 수 없습니다: {self.db_path}"
                }
            
            conn = sqlite3.connect(str(path))
            conn.row_factory = sqlite3.Row
            cursor = conn.cursor()
            
            # 여러 쿼리 실행 지원 (세미콜론으로 구분)
            queries = [q.strip() for q in query.split(';') if q.strip()]
            results = []
            
            for q in queries:
                cursor.execute(q)
                if q.strip().upper().startswith('SELECT'):
                    rows = cursor.fetchall()
                    results.append({
                        "query": q,
                        "rows": [dict(row) for row in rows],
                        "row_count": len(rows)
                    })
                else:
                    conn.commit()
                    results.append({
                        "query": q,
                        "message": "쿼리가 성공적으로 실행되었습니다.",
                        "rows_affected": cursor.rowcount
                    })
            
            conn.close()
            
            return {
                "success": True,
                "results": results
            }
        except Exception as e:
            return {
                "success": False,
                "error": str(e)
            }


class ExecuteCommandTool(Tool):
    """시스템 명령 실행 도구"""
    
    def __init__(self):
        super().__init__(
            name="execute_command",
            description="시스템 명령을 실행합니다. 주의해서 사용하세요."
        )
    
    def execute(self, command: str, **kwargs) -> Dict[str, Any]:
        try:
            result = subprocess.run(
                command,
                shell=True,
                capture_output=True,
                text=True,
                timeout=30
            )
            
            return {
                "success": result.returncode == 0,
                "stdout": result.stdout,
                "stderr": result.stderr,
                "returncode": result.returncode
            }
        except subprocess.TimeoutExpired:
            return {
                "success": False,
                "error": "명령 실행 시간이 초과되었습니다."
            }
        except Exception as e:
            return {
                "success": False,
                "error": str(e)
            }


class SearchFilesTool(Tool):
    """파일 검색 도구"""
    
    def __init__(self):
        super().__init__(
            name="search_files",
            description="파일 내용에서 텍스트를 검색합니다."
        )
    
    def execute(self, pattern: str, directory: str = ".", file_pattern: str = "*", **kwargs) -> Dict[str, Any]:
        try:
            from pathlib import Path
            import re
            
            path = Path(directory)
            matches = []
            
            for file_path in path.rglob(file_pattern):
                if file_path.is_file():
                    try:
                        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                            content = f.read()
                            if re.search(pattern, content, re.IGNORECASE):
                                matches.append({
                                    "file": str(file_path),
                                    "matches": len(re.findall(pattern, content, re.IGNORECASE))
                                })
                    except:
                        continue
            
            return {
                "success": True,
                "matches": matches,
                "pattern": pattern
            }
        except Exception as e:
            return {
                "success": False,
                "error": str(e)
            }


class ToolRegistry:
    """도구 레지스트리"""
    
    def __init__(self):
        self.tools: Dict[str, Tool] = {}
        self._register_default_tools()
    
    def _register_default_tools(self):
        """기본 도구들을 등록"""
        default_tools = [
            ReadFileTool(),
            WriteFileTool(),
            ListDirectoryTool(),
            ExecuteSQLTool(),
            ExecuteCommandTool(),
            SearchFilesTool(),
        ]
        
        for tool in default_tools:
            self.register(tool)
    
    def register(self, tool: Tool):
        """도구 등록"""
        self.tools[tool.name] = tool
    
    def get(self, name: str) -> Optional[Tool]:
        """도구 조회"""
        return self.tools.get(name)
    
    def list_tools(self) -> List[Dict[str, str]]:
        """사용 가능한 도구 목록 반환"""
        return [
            {"name": tool.name, "description": tool.description}
            for tool in self.tools.values()
        ]
