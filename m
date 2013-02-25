From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: babeltrace -i ?
Date: Mon, 25 Feb 2013 18:50:36 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD01CF4B__1178.93555802784$1361818321$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UA38l-0008U7-U6
	for lttng-dev@lists.lttng.org; Mon, 25 Feb 2013 13:51:08 -0500
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
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

   What is the babeltrace -i, --input-format option meant for?  At first I =
thought one could round-trip a CTF trace to text and back using babeltrace,=
 but if I try this:

$ babeltrace /path_to_the/ctf_trace_directory -w /path_to_the/text_trace_fi=
le
$ babeltrace /path_to_the/text_trace_file -i text -o ctf -w /path_to_the/re=
constituted_ctf_trace_directory

   The second command gives me:

[error] Cannot open any trace for reading.
[error] opening trace "/path_to_the/text_trace_file" for reading.
[error] none of the specified trace paths could be opened.

   If '-i ctf' is the only currently-implemented option, then we should get=
 a more appropriate error message when using another: something along the l=
ines of "babeltrace input format not supported ".

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
