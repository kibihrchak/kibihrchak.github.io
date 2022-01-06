#	Sourced from
#	<https://github.com/tianon/dockerfiles/blob/master/github-pages/Dockerfile>.

FROM ruby:2.7-alpine3.14

# 	Check <https://pages.github.com/versions/> for the most recent
# 	version.
ARG GITHUB_PAGES_VERSION=215

RUN set -eux; \
	\
	apk add --no-cache --virtual .build-deps \
		make \
		gcc \
		g++ \
		patch \
	; \
	\
	gem install github-pages -v "${GITHUB_PAGES_VERSION}"; \
	\
	apk del .build-deps; \
	\
	jekyll serve --help > /dev/null

RUN set -eux; \
	\
	apk add --no-cache \
		git \
	;

EXPOSE 4000
