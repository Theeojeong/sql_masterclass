"""에이전트 사용 예제"""
from agent import Agent


def example_read_file():
    """파일 읽기 예제"""
    print("=" * 60)
    print("예제 1: 파일 읽기")
    print("=" * 60)
    
    agent = Agent(name="FileReader")
    result = agent.run(
        "SQLite/#4 DATA MANIPULATION LANGUAGE/강의노트4-3.sql 파일을 읽어줘",
        context={"file_path": "SQLite/#4 DATA MANIPULATION LANGUAGE/강의노트4-3.sql"}
    )
    
    if result["success"] and "content" in result["context"]:
        print("\n파일 내용:")
        print(result["context"]["content"][:500])  # 처음 500자만 출력
    print()


def example_list_directory():
    """디렉토리 목록 예제"""
    print("=" * 60)
    print("예제 2: 디렉토리 목록 조회")
    print("=" * 60)
    
    agent = Agent(name="DirectoryLister")
    result = agent.run(
        "SQLite 폴더의 파일 목록을 보여줘",
        context={"directory": "SQLite"}
    )
    
    if result["success"] and "items" in result["context"]:
        print("\n파일 목록:")
        for item in result["context"]["items"][:10]:  # 처음 10개만
            print(f"  {item['type']:10} {item['name']}")
    print()


def example_search_files():
    """파일 검색 예제"""
    print("=" * 60)
    print("예제 3: 파일 검색")
    print("=" * 60)
    
    agent = Agent(name="FileSearcher")
    result = agent.run(
        "GROUP BY가 포함된 SQL 파일을 찾아줘",
        context={"pattern": "GROUP BY", "directory": "SQLite"}
    )
    
    if result["success"] and "matches" in result["context"]:
        print("\n검색 결과:")
        for match in result["context"]["matches"]:
            print(f"  {match['file']} ({match['matches']}개 매치)")
    print()


def example_execute_sql():
    """SQL 실행 예제"""
    print("=" * 60)
    print("예제 4: SQL 실행")
    print("=" * 60)
    
    agent = Agent(name="SQLAgent")
    
    # 먼저 테이블 구조 확인
    result = agent.run(
        "movies 테이블의 구조를 확인해줘",
        context={"query": "SELECT sql FROM sqlite_master WHERE type='table' AND name='movies'"}
    )
    
    if result["success"]:
        print("\n테이블 구조 확인 완료")
    
    # 데이터 조회
    result = agent.run(
        "movies 테이블에서 상위 5개 레코드를 조회해줘",
        context={"query": "SELECT * FROM movies LIMIT 5"}
    )
    
    if result["success"] and "results" in result["context"]:
        print("\n조회 결과:")
        for query_result in result["context"]["results"]:
            if "rows" in query_result:
                for row in query_result["rows"][:5]:
                    print(f"  {row}")
    print()


def example_complex_task():
    """복합 작업 예제"""
    print("=" * 60)
    print("예제 5: 복합 작업")
    print("=" * 60)
    
    agent = Agent(name="ComplexAgent")
    
    # 여러 단계 작업
    result = agent.run(
        "SQLite 폴더의 모든 SQL 파일을 찾아서 각 파일의 첫 100자를 읽어줘",
        context={"directory": "SQLite", "pattern": "\.sql$"}
    )
    
    if result["success"]:
        print("\n작업 완료!")
        print(f"반복 횟수: {result['iterations']}")
    print()


if __name__ == "__main__":
    print("\n🤖 에이전트 예제 실행\n")
    
    try:
        example_read_file()
        example_list_directory()
        example_search_files()
        example_execute_sql()
        example_complex_task()
        
        print("=" * 60)
        print("모든 예제 실행 완료!")
        print("=" * 60)
    except Exception as e:
        print(f"\n❌ 오류 발생: {e}")
        import traceback
        traceback.print_exc()
