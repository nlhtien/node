.PHONY: run clean
run:
	gnome-terminal -- bash -c "node server.js; exec bash" & sleep 2 && gnome-terminal -- bash -c "./send_message.sh; exec bash"
clean:
	echo -n > server.txt
