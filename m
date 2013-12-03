From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Separate trace file per app
Date: Tue, 3 Dec 2013 13:14:32 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B25D7__3838.67714922435$1386076524$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VnpoA-0000jF-FG
	for lttng-dev@lists.lttng.org; Tue, 03 Dec 2013 08:14:36 -0500
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
Cc: Anand Neeli <anand.neeli@gmail.com>
List-Id: lttng-dev@lists.lttng.org

> Date: Thu, 28 Nov 2013 15:46:31 +0530
> From: Anand Neeli <anand.neeli@gmail.com>
>
>How can i create separate trace-file per app?
>
> As shown below, i have created two trace sessions and filtered based on
> procname.
> Is this the correct way? or is there any other efficient way to do it?
>
>./lttng create app_1_trace
>./lttng enable-event -s app_1_trace -u -a --filter '$ctx.procname =3D=3D"a=
pp_1"'
>./lttng start app_1_trace
> now run app_1    ./app_1
>
>./lttng create app_2_trace
>./lttng enable-event -s app_2_trace -u -a --filter '$ctx.procname =3D=3D"a=
pp_2"'
>./lttng start app_2_trace
> now run app_2     ./app_2

   You could trace the user events per process ID.  Each process will then,=
 during its existence, create its own mini-trace within the trace folder hi=
erarchy.  You can use babeltrace to merge all processes or to extract just =
one process's trace.  Example:

$ lttng create mysession
$ lttng enable-channel mychannel --userspace --buffers-pid
$ lttng enable-event --channel mychannel --userspace --all
$ lttng start
> now run app_1, app_2

   Filters are nice but are fairly expensive CPU-wise.  With per-process tr=
acing, you can do all the requisite filtering after the fact.

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
