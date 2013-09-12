From: Stefan Seefeld <stefan@seefeld.name>
Subject: [PATCH lttng-tools] Enable support for installcheck
Date: Wed, 11 Sep 2013 20:37:40 -0400
Message-ID: <1378946261-16279-1-git-send-email-stefan_seefeld__9694.82805016941$1378946322$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stefan.seefeld@gmail.com>) id 1VJuuz-0006IG-F2
	for lttng-dev@lists.lttng.org; Wed, 11 Sep 2013 20:37:59 -0400
Received: by mail-qe0-f48.google.com with SMTP id nd7so5054545qeb.21
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 17:37:51 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Enable execution of tests via `make installcheck`, i.e. against a fully installed
LTTng.

The patch simply adds the same rule to the installcheck target that is used for check.
Testing with an OpenEmbedded build shows the unit_tests suite to work fine, while
the fast_regression suite contains many failures not present when run as `make check`. 

Stefan Seefeld (1):
  Enable support for installcheck.

 tests/Makefile.am | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
1.8.3.1
