
function check_for_venv() {
    read -d '' VENV_CHECK_STR << EOF
import sys
try:
  import virtualenv
except ImportError:
  sys.exit(1)
EOF
    python -c "$VENV_CHECK_STR"
}
    
