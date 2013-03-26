From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [LTTNG-TOOLS PATCH] UST periodical metadata flush
Date: Tue, 26 Mar 2013 14:01:06 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD029735__44096.4338639334$1364306574$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UKURw-00028o-CU
	for lttng-dev@lists.lttng.org; Tue, 26 Mar 2013 10:02:04 -0400
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
Cc: "Mathieu Desnoyers
	(mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>, "Julien Desfossez (jdesfossez@efficios.com)" <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Date: Mon, 25 Mar 2013 22:27:05 -0400
From: Julien Desfossez <jdesfossez@efficios.com>

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-cons=
umerd/lttng-consumerd.c
index 8486807..afac445 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
[...]
@@ -138,6 +140,8 @@ static void usage(FILE *fp)
 			"Specify path for the command socket\n");
 	fprintf(fp, "  -e, --consumerd-err-sock PATH     "
 			"Specify path for the error socket\n");
+	fprintf(fp, "  -e, --consumerd-metadata-sock PATH     "
+			"Specify path for the metadata socket (UST only)\n");
 	fprintf(fp, "  -d, --daemonize                    "
 			"Start as a daemon.\n");
 	fprintf(fp, "  -q, --quiet                        "
[...]
@@ -200,6 +205,9 @@ static void parse_args(int argc, char **argv)
 		case 'e':
 			snprintf(error_sock_path, PATH_MAX, "%s", optarg);
 			break;
+		case 'm':
+			snprintf(metadata_sock_path, PATH_MAX, "%s", optarg);
+			break;
 		case 'd':
 			opt_daemon =3D 1;
 			break;
+					"--consumerd-metadata-sock", consumer_data->metadata_unix_sock_path,
 					NULL);
 			if (consumerd64_libdir[0] !=3D '\0') {
 				free(tmpnew);
-----Fin du message d'origine-----

   Shouldn't the first part be:

+	fprintf(fp, "  -m, --consumerd-metadata-sock PATH     "
+			"Specify path for the metadata socket (UST only)\n");

...so it matches the second part (and doesn't ambiguate itself with with --=
consumerd-err-sock)?

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
