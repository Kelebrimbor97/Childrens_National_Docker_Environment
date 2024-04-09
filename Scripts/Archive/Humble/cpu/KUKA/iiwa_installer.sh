mkdir -p ~/lbr-stack/src && cd ~/lbr-stack
wget https://raw.githubusercontent.com/lbr-stack/lbr_fri_ros2_stack/humble/lbr_fri_ros2_stack/repos.yaml -P src
vcs import src < src/repos.yaml
source opt/ros/humble/setup.bash
rosdep update
rosdep install --from-paths src --ignore-src -r -y
source /opt/ros/humble/setup.bash
echo "source /opt/ros/humble/setup.bash">>~/.bashrc
# colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release --symlink-install
exec "$@"