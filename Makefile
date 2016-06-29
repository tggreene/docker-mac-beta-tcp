artifact = docker-mac-beta-tcp.plist
dest = /Library/LaunchDaemons/

.PHONY: run

run: install run-checks
	launchctl load $(dest)$(artifact)

install: install-checks
	cp $(artifact) $(dest)

run-checks:
	$(info Checking install...)
	@-ls $(dest)$(artifact) && echo "plist installed" || `echo "run 'make install'" ; exit 1`

install-checks:
	$(info Checking requirements...)
	@which socat && echo "socat found" || echo "socat required 'brew install socat'"

post-install-checks:
	curl http://localhost:2375/version
