From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [LTTNG-TOOLS PATCH] On-disk multiple tracefiles
 circular buffer - revisited
Date: Mon, 25 Mar 2013 13:53:26 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD02944A__27968.5971363962$1364219720$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UK7qx-00076v-Ub
	for lttng-dev@lists.lttng.org; Mon, 25 Mar 2013 09:54:24 -0400
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

   Here are proposed semantics for the tracefile-size/tracefile-count enabl=
e-channel options (are they still planned for later inclusion in lttng-tool=
s?):

-C, --tracefile-size SIZE
	This is a recent proposal (2013-Mar-08) that has yet to be added to the co=
mmand.  Maximum size of each stored trace file (local or remote).  Default =
is zero, which means no limitation.  When set, each trace file is chopped i=
nto sequentially numbered segments of at most SIZE bytes each (e.g. "channe=
l0_0" becomes "channel0_0_0", "channel0_0_1", etc.).  SIZE must be at least=
 as large as the sub-buffer size.  The option is most useful if -W, --trace=
file-count is also set.

-W, --tracefile-count NUM
	This is a recent proposal (2013-Mar-08) that has yet to be added to the co=
mmand.  Maximum number of stored trace file chunks (local or remote).  Defa=
ult is zero, which means no limitation.  When set, once the number of trace=
 file segments reaches NUM the first segments are re-used (overwritten), cr=
eating an on-disc circular buffer of sorts.  The option has no effect unles=
s the -C, --tracefile-size option is also set.

   Note that when -C is set but -W is not (or if -W is set to 1), this mean=
s the single trace file gets overwritten after each SIZE bytes.

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
