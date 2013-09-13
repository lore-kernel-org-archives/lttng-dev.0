From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Enable support for installcheck
Date: Fri, 13 Sep 2013 16:07:07 -0400
Message-ID: <5233706B.6030309__27962.642935063$1379102893$gmane$org@efficios.com>
References: <1378946261-16279-1-git-send-email-stefan_seefeld@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VKZeA-0005R6-5Z
	for lttng-dev@lists.lttng.org; Fri, 13 Sep 2013 16:07:24 -0400
In-Reply-To: <1378946261-16279-1-git-send-email-stefan_seefeld@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan@seefeld.name>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged thanks!

David

Stefan Seefeld:
> Enable execution of tests via `make installcheck`, i.e. against a fully installed
> LTTng.
> 
> The patch simply adds the same rule to the installcheck target that is used for check.
> Testing with an OpenEmbedded build shows the unit_tests suite to work fine, while
> the fast_regression suite contains many failures not present when run as `make check`. 
> 
> Stefan Seefeld (1):
>   Enable support for installcheck.
> 
>  tests/Makefile.am | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
