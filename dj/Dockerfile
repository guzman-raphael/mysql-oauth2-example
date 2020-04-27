FROM raphaelguzman/jupyter:1.0.0-python3.7-alpine as jup_build

USER dja:anaconda
# RUN \
#     conda install -yc conda-forge python=$PY_VER jupyterlab jupyterhub=$JUPYTERHUB_VERSION && \
#     # find /opt/conda -user 3000 -exec chmod g+w "{}" \; && \
#     conda clean -ya
RUN \
    pip install --no-cache-dir jupyterlab_iframe && \
    conda install -c conda-forge nodejs=11.10.0 datajoint && \
    jupyter labextension install jupyterlab_iframe && \
    jupyter serverextension enable --py jupyterlab_iframe && \
    chmod -R o+w /home/dja/.cache && \
    find /opt/conda -user 3000 -exec chmod g+w "{}" \; 
USER root
RUN \
    chmod -R g+rwx /home/dja/.config

# #Squashed Final Image
FROM scratch
COPY --from=jup_build / /
ENV PYTHON_USER dja
RUN chmod 4755 /startup && /startup 3000 anaconda
LABEL maintainerName="Raphael Guzman" \
      maintainerEmail="raphael@vathes.com" \
      maintainerCompany="DataJoint"
USER dja:anaconda
ENV HOME /home/dja
ENV LANG C.UTF-8
ENV APK_REQUIREMENTS /apk_requirements.txt
ENV PIP_REQUIREMENTS /pip_requirements.txt
ENV CONDA_REQUIREMENTS /conda_requirements.txt
ENV PATH "/home/dja/.local/bin:/opt/conda/bin:$PATH"
ENTRYPOINT ["/entrypoint.sh"]
WORKDIR /src
VOLUME /src
VOLUME /tmp/.X11-unix
EXPOSE 8888
CMD ["jupyter", "lab"]