From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: No trace files are generated for UST
Date: Mon, 9 Dec 2013 13:53:52 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B3249__22424.2928241894$1386599547$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <6CFA219DE9CAD940989B83CA579159F91B43ACBFBE@SGSINEXC014.vestas.net>
	<48CF5AC71E61DB46B70D0F388054EFFD267B2DCF@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0B6@SGSINEXC014.vestas.net>
	<48CF5AC71E61DB46B70D0F388054EFFD267B2DF5@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0C1@SGSINEXC014.vestas.net>
	<CA+jJMxt-D9CEFVhH93Q7iy=0W1KRsynBA9is-AP3L0+Dpq11Cg@mail.gmail.com>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0FD@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Vq1HX-0002Jm-17
	for lttng-dev@lists.lttng.org; Mon, 09 Dec 2013 08:54:00 -0500
In-Reply-To: <6CFA219DE9CAD940989B83CA579159F91B43ACC0FD@SGSINEXC014.vestas.net>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Manikandan Govindaswamy <magov@vestas.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

   A first glance through the log reveals these possibly significant entrie=
s:

DEBUG1 [15860/15996]: Sending response (size: 16, retcode: Unknown error co=
de) (in thread_manage_clients() at main.c:3803)

And later

PERROR [16322/16322]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at =
unix.c:218)

   What were the client commands used to generate the log?  And what was th=
e running environment (which versions of the LTTng suite were installed, an=
d which session daemon(s) is(are) running? ).

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
