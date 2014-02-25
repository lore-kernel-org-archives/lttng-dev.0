From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: [lttng-tools][Patch] Fix format + PACKAGE_URL for
	dynamic printing
Date: Tue, 25 Feb 2014 13:04:17 -0500
Message-ID: <20140225180414.GA29130__7779.89703133262$1393351537$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jonathan.r.julien@gmail.com>) id 1WIMMp-00021c-14
	for lttng-dev@lists.lttng.org; Tue, 25 Feb 2014 13:04:39 -0500
Received: by mail-ie0-f170.google.com with SMTP id y20so662117ier.15
	for <lttng-dev@lists.lttng.org>; Tue, 25 Feb 2014 10:04:25 -0800 (PST)
Received: from gmail.com
	(Sansfil-Securise-Etudiants-Lassonde-242-35.polymtl.ca.
	[132.207.242.35])
	by mx.google.com with ESMTPSA id hs6sm39713640igb.2.2014.02.25.10.04.19
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Tue, 25 Feb 2014 10:04:19 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

---
 src/bin/lttng/commands/version.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/bin/lttng/commands/version.c b/src/bin/lttng/commands/vers=
ion.c
index bd88659..2b41b05 100644
--- a/src/bin/lttng/commands/version.c
+++ b/src/bin/lttng/commands/version.c
@@ -87,10 +87,10 @@ int cmd_version(int argc, const char **argv)
 		}
 	}
 =

-	MSG("lttng version " VERSION " - " VERSION_NAME);
+	MSG("LTTng version " VERSION " - " VERSION_NAME);
 	MSG("\n" VERSION_DESCRIPTION "\n");
-	MSG("Web site: http://lttng.org");
-	MSG("\nlttng is free software and under the GPL license and part LGPL");
+	MSG("Web site: " PACKAGE_URL "\n");
+	MSG("LTTng is free software and under the GPL license and part LGPL");
 =

 end:
 	poptFreeContext(pc);
-- =

1.7.9.5


-- =

Jonathan Rajotte Julien
Charg=E9 de laboratoire INF1995
Membre MD6
Polytechnique Montr=E9al
