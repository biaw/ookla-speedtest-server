# Ookla Speedtest Server

The official Ookla Speedtest Server, unofficially dockerized.

This image is available via the GitHub Container Registry, and you can pull it like any other image:

```bash
docker pull ghcr.io/biaw/ookla-speedtest-server:latest
```

## How to set up

Copy the `OoklaServer.properties` to a folder on your host machine, and edit to however you'd like. Currently, there's no way to configure the server via environment variables, so you'll have to edit the file manually. However, there might come a time when I'll add support for it.

```bash
docker run -d \
  --name speedtest \
  -p 8080/tcp -p 8080/udp -p 5060/tcp -p 5060/udp \
  -v /path/to/your/OoklaServer.properties:/opt/ookla/OoklaServer.properties \
  ghcr.io/biaw/ookla-speedtest-server:latest
```

Make sure the ports you're exposing are the same as the ones you've set in the `OoklaServer.properties` file.

## What happens if there is an update?

Looking at the [Ookla Speedtest Server patch notes](https://support.ookla.com/hc/en-us/articles/234578608-Speedtest-Server-Release-Notes), there hasn't been an update since late 2021. So I'm not concerned about it. However, if there is an update, I'll update the image as soon as I can. You can also enable the auto updater in the `OoklaServer.properties` file, however I've not tested how well this works yet as there hasn't been an update yet.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. Ookla Speedtest Server is licensed under the [Ookla EULA](https://www.speedtest.net/about/eula).
