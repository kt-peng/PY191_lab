ggmmc() {
    local hours="${1:-2}"
    local gpu_session="gpu"
    if ! tmux has-session -t "$gpu_session" 2>/dev/null; then
        echo "Launching GPU instance for ${hours} hours";
        tmux new-session -d -s "$gpu_session" \
            "qrsh -now n -P otmesh -pe omp 10 -binding linear:10 -l gpus=1 -l gpu_memory=4G -l gpu_c=8.0 -l h_rt=${hours}:00:00"
    fi

    tmux attach -t "$gpu_session"
}


gmmc() {
    cpu_session="cpu"

    if ! tmux has-session -t "$cpu_session" 2>/dev/null; then
        tmux new-session -d -s "$cpu_session" \
            'qrsh -now n -P otmesh -pe omp 20 -l h_rt=10:00:00'
    fi

    tmux attach -t "$cpu_session"
}
