"""에이전트 메인 실행 스크립트"""
import sys
import argparse
from .agent import Agent


def main():
    parser = argparse.ArgumentParser(description="자율 에이전트 실행")
    parser.add_argument(
        "goal",
        nargs="?",
        help="에이전트가 수행할 목표"
    )
    parser.add_argument(
        "--name",
        default="Agent",
        help="에이전트 이름"
    )
    parser.add_argument(
        "--max-iterations",
        type=int,
        default=20,
        help="최대 반복 횟수"
    )
    parser.add_argument(
        "--interactive",
        "-i",
        action="store_true",
        help="대화형 모드"
    )
    
    args = parser.parse_args()
    
    agent = Agent(name=args.name, max_iterations=args.max_iterations)
    
    if args.interactive:
        print("🤖 자율 에이전트 대화형 모드")
        print("종료하려면 'quit' 또는 'exit'를 입력하세요.\n")
        
        while True:
            try:
                goal = input("목표를 입력하세요: ").strip()
                
                if goal.lower() in ["quit", "exit", "종료"]:
                    print("👋 안녕히 가세요!")
                    break
                
                if not goal:
                    continue
                
                result = agent.run(goal)
                
                # 결과 요약 출력
                if result["success"]:
                    print(f"\n✅ 작업이 성공적으로 완료되었습니다!")
                else:
                    print(f"\n⚠️  작업이 완료되지 않았습니다.")
                
                print(f"반복 횟수: {result['iterations']}\n")
                
            except KeyboardInterrupt:
                print("\n\n👋 안녕히 가세요!")
                break
            except Exception as e:
                print(f"\n❌ 오류 발생: {e}\n")
    
    elif args.goal:
        result = agent.run(args.goal)
        
        # JSON 출력 옵션
        if "--json" in sys.argv:
            import json
            print(json.dumps(result, indent=2, ensure_ascii=False))
        else:
            if result["success"]:
                print(f"\n✅ 작업이 성공적으로 완료되었습니다!")
            else:
                print(f"\n⚠️  작업이 완료되지 않았습니다.")
            print(f"반복 횟수: {result['iterations']}")
    
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
