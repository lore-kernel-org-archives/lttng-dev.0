From: Klaus Dannecker <klaus.dannecker@gmx.de>
Subject: Re: make a trace_event in a modul (driver)
Date: Sun, 24 Nov 2013 12:43:49 +0100
Message-ID: <5291E675.8070908__33228.3221454874$1385293443$gmane$org@gmx.de>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5932@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.17.21])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <klaus.dannecker@gmx.de>) id 1VkY5x-0006Qc-Bd
	for lttng-dev@lists.lttng.org; Sun, 24 Nov 2013 06:43:22 -0500
Received: from [192.168.178.21] ([178.2.15.135]) by mail.gmx.com (mrgmx001)
	with ESMTPSA (Nemesis) id 0MOf5S-1VhoGb140E-0064R6 for
	<lttng-dev@lists.lttng.org>; Sun, 24 Nov 2013 12:43:15 +0100
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267A5932@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Am 22.11.2013 19:54, schrieb Thibault, Daniel:
>> how can I define a "tracing"group , so I no longer need the sudo command?
> $ sudo addgroup --system tracing
> $ sudo adduser username tracing
>
> You must log off and back on for group membership to be activated.
>
> You may also want to add lttng-sessiond as a service:
>
> $ sudo ln --symbolic /lib/init/upstart-job /etc/init.d/lttng-sessiond
>
> And create /etc/init/lttng-sessiond.conf containing:
>
> description "LTTng central tracing registry session daemon"
> author "St=E9phane Graber <stgraber@ubuntu.com>"
> start on local-filesystems
> stop on runlevel [06]
> respawn
> exec lttng-sessiond
>
> You can then start the session daemon with 'sudo service lttng-sessiond s=
tart' (stop it with 'stop', restart with 'restart').
Thanks, now it works
but when i
$ lttng create
$ lttng enable-event -k -a
$ lttng start
so, the function does not return!
only 'strg c' terminated the fuktion.

the same by
$ lttng stop
and
$ lttng destroy

but
$ lttng create
$ lttng enable-event -u -a
$ lttng start
$ lttng stop
$ lttng destroy
-> works

how can i remove all installed lttng_modules,
so that I can start again from the beginning?

Thanks
Klaus
sorry, i am a linux beginner

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
