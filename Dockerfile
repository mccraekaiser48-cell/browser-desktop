# A real Chromium on a virtual display, served over noVNC on $PORT.
#
# Any host that runs a container works: Render's free web service, a free VM,
# Fly, Koyeb, or `docker run` on your own machine. Nothing here needs a
# credit card; the image is plain Debian plus apt packages.
#
#   docker build -t browser-desktop desktop
#   docker run --rm -p 7860:7860 browser-desktop
#   open http://localhost:7860/vnc.html
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY_NUM=1 \
    SCREEN=1280x720x16 \
    PORT=7860 \
    START_URL=https://search.brave.com/

RUN apt-get update && apt-get install -y --no-install-recommends \
      xvfb \
      x11vnc \
      novnc \
      websockify \
      chromium \
      fonts-liberation \
      fonts-noto-color-emoji \
      ca-certificates \
      curl \
      procps \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 7860
CMD ["/usr/local/bin/start.sh"]
