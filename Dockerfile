# 使用althack/ros2作为基础镜像
FROM althack/ros:noetic-full

WORKDIR /catkin_ws

RUN apt-get update && \
    apt-get install -y python3-catkin-tools python3-vcstool python3-osrf-pycommon && \
    apt-get install -y libglew-dev libopencv-dev libyaml-cpp-dev && \
    apt-get install -y libblas-dev liblapack-dev libsuitesparse-dev wget && \
    catkin config --init --mkdirs --extend /opt/ros/noetic --cmake-args -DCMAKE_BUILD_TYPE=Release -DEIGEN3_INCLUDE_DIR=/usr/include/eigen3 && \
    cd src && \
    mkdir rpg_svo_pro_open

COPY . /catkin_ws/src/rpg_svo_pro_open/

#  git clone https://github.com/uzh-rpg/rpg_svo_pro_open.git && \
RUN cd /catkin_ws/src/ && \
    vcs-import < ./rpg_svo_pro_open/dependencies.yaml && \
    touch minkindr/minkindr_python/CATKIN_IGNORE && \
    cd rpg_svo_pro_open/svo_online_loopclosing/vocabularies && ./download_voc.sh 
    # cd ../../.. && \
    # catkin build



