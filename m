From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: What are sys calls starting with compat?
Date: Wed, 11 Dec 2013 14:23:15 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B364D__42936.1873692416$1386771854$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Vqkh2-0000ST-Qe
	for lttng-dev@lists.lttng.org; Wed, 11 Dec 2013 09:23:19 -0500
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
Cc: Shariyar <syed.shariyar@gmail.com>
List-Id: lttng-dev@lists.lttng.org

> > Date: Tue, 10 Dec 2013 11:39:40 -0800
> > What does sys_unknown mean and why does it occur? Does it mean that LTT=
ng cannot find the name of a system call?
> >
> Yes. It means the ID of the system call is unknown to LTTng (e.g. kernel =
newer than LTTng system call instrumentation). =


   You can also get sys_ni_syscall (and compat_sys_ni_syscall) when the sys=
tem call is even more unknown -that is to say, when the system call number =
cannot be found in the system call dispatch table.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
