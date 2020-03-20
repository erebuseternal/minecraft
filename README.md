# minecraft

# Operations

## Starting for the First Time
```bash
sudo docker build -t mgietzmann/minecraft:latest .
sudo docker container run -it --name=minecraft -p 25565:25565 mgietzmann/minecraft:latest
bash run_server.sh
```

This is going to put you in a window where you'll get the feed from the minecraft server. So if you want to stop the server just type `stop` and the server will exit out safely. When you close out of this window the container itself will exit. 

## Starting the Server Subsequently
So you've exited from the container in the past and now want to start it back up again. Well now that the container is there all you need to do is:
```bash
sudo docker container start minecraft
sudo docker attach minecraft
bash run_server.sh
```

All of your saved worlds will still be in there waiting for you as you're starting from the state the container was in when you exited. When you leave the window you've opened the container will exit again.

## Backing up Your Container
Every once in a while you'll want to back up the current state of the server so that if your game gets corrupted or something like that you'll have something to come back to. We'll do this by just uploading the whole container. (Overkill I know) Here's what you gotta do. (Assuming you've exited the server)
```bash
sudo docker login --username=mgietzmann
sudo docker commit --author mgietzmann minecraft mgietzmann/minecraft:<date>
sudo docker push mgietzmann/minecraft:<date>
```
