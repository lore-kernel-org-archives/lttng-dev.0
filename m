From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: [PATCH lttng-tools] Fix: document lttng-sessiond short
 options
Date: Wed, 4 Sep 2013 20:54:24 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2678D1A8__16747.1561501317$1378328148$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VHK61-0004bD-Vl
	for lttng-dev@lists.lttng.org; Wed, 04 Sep 2013 16:54:44 -0400
Content-Language: fr-FR
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

Fixes #588, which was closed prematurely

'lttng-sessiond -h' documents its short options; '-Z' no longer requires an=
 argument; '-s' removed; '-GHTU' handled; usage formatted to 80 columns; us=
age, parse_args and long_options[] now in synch
(The attached diff was prepared semi-manually and is missing the 'index' li=
ne, my apologies)

Signed-off-by: Daniel U. Thibault <daniel.thibault@drdc-rddc.gc.ca>
---
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -3861,28 +3861,31 @@
 static void usage(void)
 {
 	fprintf(stderr, "Usage: %s OPTIONS\n\nOptions:\n", progname);
-	fprintf(stderr, "  -h, --help                         Display this usage.=
\n");
-	fprintf(stderr, "  -c, --client-sock PATH             Specify path for th=
e client unix socket\n");
-	fprintf(stderr, "  -a, --apps-sock PATH               Specify path for ap=
ps unix socket\n");
-	fprintf(stderr, "      --kconsumerd-err-sock PATH     Specify path for th=
e kernel consumer error socket\n");
-	fprintf(stderr, "      --kconsumerd-cmd-sock PATH     Specify path for th=
e kernel consumer command socket\n");
-	fprintf(stderr, "      --ustconsumerd32-err-sock PATH Specify path for th=
e 32-bit UST consumer error socket\n");
-	fprintf(stderr, "      --ustconsumerd64-err-sock PATH Specify path for th=
e 64-bit UST consumer error socket\n");
-	fprintf(stderr, "      --ustconsumerd32-cmd-sock PATH Specify path for th=
e 32-bit UST consumer command socket\n");
-	fprintf(stderr, "      --ustconsumerd64-cmd-sock PATH Specify path for th=
e 64-bit UST consumer command socket\n");
-	fprintf(stderr, "      --consumerd32-path PATH     Specify path for the 3=
2-bit UST consumer daemon binary\n");
-	fprintf(stderr, "      --consumerd32-libdir PATH   Specify path for the 3=
2-bit UST consumer daemon libraries\n");
-	fprintf(stderr, "      --consumerd64-path PATH     Specify path for the 6=
4-bit UST consumer daemon binary\n");
-	fprintf(stderr, "      --consumerd64-libdir PATH   Specify path for the 6=
4-bit UST consumer daemon libraries\n");
+	fprintf(stderr, "  -h, --help                         Display this usage =
and quit.\n");
+	fprintf(stderr, "  -V, --version                      Show version number=
 and quit.\n");
 	fprintf(stderr, "  -d, --daemonize                    Start as a daemon.\=
n");
-	fprintf(stderr, "  -g, --group NAME                   Specify the tracing=
 group name. (default: tracing)\n");
-	fprintf(stderr, "  -V, --version                      Show version number=
.\n");
-	fprintf(stderr, "  -S, --sig-parent                   Send SIGCHLD to par=
ent pid to notify readiness.\n");
 	fprintf(stderr, "  -q, --quiet                        No output at all.\n=
");
-	fprintf(stderr, "  -v, --verbose                      Verbose mode. Activ=
ate DBG() macro.\n");
-	fprintf(stderr, "  -p, --pidfile FILE                 Write a pid to FILE=
 name overriding the default value.\n");
-	fprintf(stderr, "      --verbose-consumer             Verbose mode for co=
nsumer. Activate DBG() macro.\n");
-	fprintf(stderr, "      --no-kernel                    Disable kernel trac=
er\n");
+	fprintf(stderr, "  -v, --verbose                      Verbose mode. Activ=
ates DBG() macro.\n");
+	fprintf(stderr, "  -Z, --verbose-consumer             Verbose consumer. A=
ctivates DBG() macro.\n");
+	fprintf(stderr, "  -S, --sig-parent                   Send SIGCHLD to par=
ent to notify readiness.\n");
+	fprintf(stderr, "  -N, --no-kernel                    Disable kernel trac=
er\n");
+	fprintf(stderr, "  -g, --group NAME                   Specify the tracing=
 group name.\n");
+	fprintf(stderr, "                                     (default: tracing)\=
n");
+	fprintf(stderr, "  -p, --pidfile FILE                 Write the daemon's =
pid to FILE.\n");
+	fprintf(stderr, "                                     (default: lttng-ses=
siond.pid)\n");
+	fprintf(stderr, "Specify paths for unix sockets, binaries and libraries:\=
n");
+	fprintf(stderr, "  -a, --apps-sock PATH               Apps unix socket.\n=
");
+	fprintf(stderr, "  -c, --client-sock PATH             Client unix socket.=
\n");
+	fprintf(stderr, "  -C, --kconsumerd-cmd-sock PATH     Kernel consumer com=
mand socket.\n");
+	fprintf(stderr, "  -E, --kconsumerd-err-sock PATH     Kernel consumer err=
or socket.\n");
+	fprintf(stderr, "  -D, --ustconsumerd64-cmd-sock PATH 64-bit UST consumer=
 command socket.\n");
+	fprintf(stderr, "  -F, --ustconsumerd64-err-sock PATH 64-bit UST consumer=
 error socket.\n");
+	fprintf(stderr, "  -G, --ustconsumerd32-cmd-sock PATH 32-bit UST consumer=
 command socket.\n");
+	fprintf(stderr, "  -H, --ustconsumerd32-err-sock PATH 32-bit UST consumer=
 error socket.\n");
+	fprintf(stderr, "  -t, --consumerd64-path PATH        64-bit UST consumer=
 daemon binary.\n");
+	fprintf(stderr, "  -T, --consumerd64-libdir PATH      64-bit UST consumer=
 daemon libraries.\n");
+	fprintf(stderr, "  -u, --consumerd32-path PATH        32-bit UST consumer=
 daemon binary.\n");
+	fprintf(stderr, "  -U, --consumerd32-libdir PATH      32-bit UST consumer=
 daemon libraries.\n");
 }
 =

 /*
@@ -3893,34 +3896,34 @@
 	int c;
 =

 	static struct option long_options[] =3D {
-		{ "client-sock", 1, 0, 'c' },
-		{ "apps-sock", 1, 0, 'a' },
-		{ "kconsumerd-cmd-sock", 1, 0, 'C' },
-		{ "kconsumerd-err-sock", 1, 0, 'E' },
-		{ "ustconsumerd32-cmd-sock", 1, 0, 'G' },
-		{ "ustconsumerd32-err-sock", 1, 0, 'H' },
-		{ "ustconsumerd64-cmd-sock", 1, 0, 'D' },
-		{ "ustconsumerd64-err-sock", 1, 0, 'F' },
-		{ "consumerd32-path", 1, 0, 'u' },
-		{ "consumerd32-libdir", 1, 0, 'U' },
-		{ "consumerd64-path", 1, 0, 't' },
-		{ "consumerd64-libdir", 1, 0, 'T' },
-		{ "daemonize", 0, 0, 'd' },
-		{ "sig-parent", 0, 0, 'S' },
 		{ "help", 0, 0, 'h' },
-		{ "group", 1, 0, 'g' },
 		{ "version", 0, 0, 'V' },
+		{ "daemonize", 0, 0, 'd' },
 		{ "quiet", 0, 0, 'q' },
 		{ "verbose", 0, 0, 'v' },
 		{ "verbose-consumer", 0, 0, 'Z' },
+		{ "sig-parent", 0, 0, 'S' },
 		{ "no-kernel", 0, 0, 'N' },
+		{ "group", 1, 0, 'g' },
 		{ "pidfile", 1, 0, 'p' },
+		{ "apps-sock", 1, 0, 'a' },
+		{ "client-sock", 1, 0, 'c' },
+		{ "kconsumerd-cmd-sock", 1, 0, 'C' },
+		{ "kconsumerd-err-sock", 1, 0, 'E' },
+		{ "ustconsumerd64-cmd-sock", 1, 0, 'D' },
+		{ "ustconsumerd64-err-sock", 1, 0, 'F' },
+		{ "ustconsumerd32-cmd-sock", 1, 0, 'G' },
+		{ "ustconsumerd32-err-sock", 1, 0, 'H' },
+		{ "consumerd64-path", 1, 0, 't' },
+		{ "consumerd64-libdir", 1, 0, 'T' },
+		{ "consumerd32-path", 1, 0, 'u' },
+		{ "consumerd32-libdir", 1, 0, 'U' },
 		{ NULL, 0, 0, 0 }
 	};
 =

 	while (1) {
 		int option_index =3D 0;
-		c =3D getopt_long(argc, argv, "dhqvVSN" "a:c:g:s:C:E:D:F:Z:u:t:p:",
+		c =3D getopt_long(argc, argv, "hVdqvZSN" "g:p:a:c:C:E:D:F:G:H:t:T:u:U:",
 				long_options, &option_index);
 		if (c =3D=3D -1) {
 			break;
@@ -3933,57 +3936,66 @@
 				fprintf(stderr, " with arg %s\n", optarg);
 			}
 			break;
-		case 'c':
-			snprintf(client_unix_sock_path, PATH_MAX, "%s", optarg);
-			break;
-		case 'a':
-			snprintf(apps_unix_sock_path, PATH_MAX, "%s", optarg);
-			break;
-		case 'd':
-			opt_daemon =3D 1;
-			break;
-		case 'g':
-			opt_tracing_group =3D optarg;
-			break;
 		case 'h':
 			usage();
 			exit(EXIT_FAILURE);
 		case 'V':
 			fprintf(stdout, "%s\n", VERSION);
 			exit(EXIT_SUCCESS);
+		case 'd':
+			opt_daemon =3D 1;
+			break;
+		case 'q':
+			lttng_opt_quiet =3D 1;
+			break;
+		case 'v':
+			/* Verbose level can increase using multiple -v */
+			lttng_opt_verbose +=3D 1;
+			break;
+		case 'Z':
+			opt_verbose_consumer +=3D 1;
+			break;
 		case 'S':
 			opt_sig_parent =3D 1;
 			break;
-		case 'E':
-			snprintf(kconsumer_data.err_unix_sock_path, PATH_MAX, "%s", optarg);
+		case 'N':
+			opt_no_kernel =3D 1;
+			break;
+		case 'g':
+			opt_tracing_group =3D optarg;
+			break;
+		case 'p':
+			opt_pidfile =3D optarg;
+			break;
+		case 'a':
+			snprintf(apps_unix_sock_path, PATH_MAX, "%s", optarg);
+			break;
+		case 'c':
+			snprintf(client_unix_sock_path, PATH_MAX, "%s", optarg);
 			break;
 		case 'C':
 			snprintf(kconsumer_data.cmd_unix_sock_path, PATH_MAX, "%s", optarg);
 			break;
-		case 'F':
-			snprintf(ustconsumer64_data.err_unix_sock_path, PATH_MAX, "%s", optarg);
+		case 'E':
+			snprintf(kconsumer_data.err_unix_sock_path, PATH_MAX, "%s", optarg);
 			break;
 		case 'D':
 			snprintf(ustconsumer64_data.cmd_unix_sock_path, PATH_MAX, "%s", optarg);
 			break;
-		case 'H':
-			snprintf(ustconsumer32_data.err_unix_sock_path, PATH_MAX, "%s", optarg);
+		case 'F':
+			snprintf(ustconsumer64_data.err_unix_sock_path, PATH_MAX, "%s", optarg);
 			break;
 		case 'G':
 			snprintf(ustconsumer32_data.cmd_unix_sock_path, PATH_MAX, "%s", optarg);
 			break;
-		case 'N':
-			opt_no_kernel =3D 1;
-			break;
-		case 'q':
-			lttng_opt_quiet =3D 1;
+		case 'H':
+			snprintf(ustconsumer32_data.err_unix_sock_path, PATH_MAX, "%s", optarg);
 			break;
-		case 'v':
-			/* Verbose level can increase using multiple -v */
-			lttng_opt_verbose +=3D 1;
+		case 't':
+			consumerd64_bin =3D optarg;
 			break;
-		case 'Z':
-			opt_verbose_consumer +=3D 1;
+		case 'T':
+			consumerd64_libdir =3D optarg;
 			break;
 		case 'u':
 			consumerd32_bin=3D optarg;
@@ -3991,15 +4003,6 @@
 		case 'U':
 			consumerd32_libdir =3D optarg;
 			break;
-		case 't':
-			consumerd64_bin =3D optarg;
-			break;
-		case 'T':
-			consumerd64_libdir =3D optarg;
-			break;
-		case 'p':
-			opt_pidfile =3D optarg;
-			break;
 		default:
 			/* Unknown option or other error.
 			 * Error is printed by getopt, just return */
--
Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
