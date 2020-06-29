DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_ROOT="$DIR/.."

mkdocs build --clean --strict \
--config-file "$PROJECT_ROOT/tech-spec/mkdocs.yml" \
--site-dir "$PROJECT_ROOT/docs"


