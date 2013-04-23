From: Stefan Seefeld <stefan@codesourcery.com>
Subject: [PATCH lttng-tools] Add --version command-line option
	to lttng.
Date: Tue, 23 Apr 2013 17:14:57 -0400
Message-ID: <5176F9D1.8010907__23664.7781487138$1366752909$gmane$org@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1UUkYK-0005il-Np
	for lttng-dev@lists.lttng.org; Tue, 23 Apr 2013 17:15:04 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch adds a --version option to the 'lttng' tool, making it easier
for users to check the version, and with that, the set of features
supported.
(It would also be useful to canonicalize and document the version string
grammar so it can be easily parsed and converted to a numeric value for
comparison.)


Signed-off-by: Stefan Seefeld <stefan@codesourcery.com>
---
 src/bin/lttng/lttng.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
index 79a28ba..3848a0d 100644
--- a/src/bin/lttng/lttng.c
+++ b/src/bin/lttng/lttng.c
@@ -47,6 +47,7 @@ enum {

 /* Getopt options. No first level command. */
 static struct option long_options[] = {
+       {"version",          0, NULL, 'V'},
        {"help",             0, NULL, 'h'},
        {"group",            1, NULL, 'g'},
        {"verbose",          0, NULL, 'v'},
@@ -85,6 +86,7 @@ static void usage(FILE *ofp)
        fprintf(ofp, "usage: lttng [OPTIONS] <COMMAND> [<ARGS>]\n");
        fprintf(ofp, "\n");
        fprintf(ofp, "Options:\n");
+       fprintf(ofp, "  -V, --version              Show version\n");
        fprintf(ofp, "  -h, --help                 Show this help\n");
        fprintf(ofp, "      --list-options         Simple listing of
lttng options\n");
        fprintf(ofp, "      --list-commands        Simple listing of
lttng commands\n");
@@ -116,6 +118,10 @@ static void usage(FILE *ofp)
        fprintf(ofp, "See http://lttng.org for updates, bug reports and
news.\n");
 }

+static void version(FILE *ofp)
+{
+  fprintf(ofp, "lttng (LTTng Trace Control) " VERSION" - "
VERSION_NAME"\n\n");
+}
 /*
  *  list_options


  *
@@ -426,8 +432,12 @@ static int parse_args(int argc, char **argv)


                clean_exit(EXIT_FAILURE);
        }

-       while ((opt = getopt_long(argc, argv, "+hnvqg:", long_options,
NULL)) != -1) {
+       while ((opt = getopt_long(argc, argv, "+Vhnvqg:", long_options,
NULL)) != -1) {
                switch (opt) {
+               case 'V':
+                       version(stdout);
+                       ret = 0;
+                       goto end;
                case 'h':
                        usage(stdout);
                        ret = 0;
-- 
1.8.1.4


-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
stefan@codesourcery.com
