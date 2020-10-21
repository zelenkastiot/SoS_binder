FROM jupyter/datascience-notebook

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        emacs \
        git \
        inkscape \
        jed \
        libsm6 \
        libxext-dev \
        libxrender1 \
        lmodern \
        netcat \
        unzip \
        nano \
        curl \
        wget \
        cmake \
        rsync \
        gnuplot-x11 \
        libopenblas-base \
        python3-dev \
        ttf-dejavu && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN julia -e 'import Pkg; Pkg.add("GZip"); Pkg.add("PyPlot"); Pkg.precompile();'

RUN cd $HOME/work;\
    pip install --upgrade pip; \
    pip install sos\
                sos-notebook \
                sos-python \
                sos-bash \
                sos-matlab \
                sos-ruby \
                sos-sas \
                sos-julia \
                sos-javascript\
                sos-r\
                scipy \
                plotly \
                dash \
                dash_core_components \
                dash_html_components \
                dash_dangerously_set_inner_html \
                dash-renderer \
                flask \
                ipywidgets \
                nbconvert; \
    python -m sos_notebook.install;\
    git clone --single-branch -b master https://github.com/zelenkastiot/SoS_binder.git; \	    
    cd SoS_binder;\	    
    chmod -R 777 $HOME/work/SoS_binder
    
WORKDIR $HOME/work/SoS_binder

USER $NB_UID
