From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: make a trace_event in a modul (driver)
Date: Sun, 24 Nov 2013 11:01:24 -0500
Message-ID: <CA+jJMxssu064JygayJ6KvcMb2AwbPsV5RHugtpO5ZZ9UsvcqOw__48170.186012476$1385308934$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5932@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<5291E675.8070908@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Vkc7m-0005r3-F5
	for lttng-dev@lists.lttng.org; Sun, 24 Nov 2013 11:01:32 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so2158144qab.16
	for <lttng-dev@lists.lttng.org>; Sun, 24 Nov 2013 08:01:24 -0800 (PST)
In-Reply-To: <5291E675.8070908@gmx.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Klaus Dannecker <klaus.dannecker@gmx.de>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Thibault,
	Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

On Sun, Nov 24, 2013 at 6:43 AM, Klaus Dannecker <klaus.dannecker@gmx.de> w=
rote:
>
> Am 22.11.2013 19:54, schrieb Thibault, Daniel:
>
>>> how can I define a "tracing"group , so I no longer need the sudo comman=
d?
>>
>> $ sudo addgroup --system tracing
>> $ sudo adduser username tracing
>>
>> You must log off and back on for group membership to be activated.
>>
>> You may also want to add lttng-sessiond as a service:
>>
>> $ sudo ln --symbolic /lib/init/upstart-job /etc/init.d/lttng-sessiond
>>
>> And create /etc/init/lttng-sessiond.conf containing:
>>
>> description "LTTng central tracing registry session daemon"
>> author "St=E9phane Graber <stgraber@ubuntu.com>"
>> start on local-filesystems
>> stop on runlevel [06]
>> respawn
>> exec lttng-sessiond
>>
>> You can then start the session daemon with 'sudo service lttng-sessiond
>> start' (stop it with 'stop', restart with 'restart').
>
> Thanks, now it works
> but when i
> $ lttng create
> $ lttng enable-event -k -a
> $ lttng start
> so, the function does not return!
> only 'strg c' terminated the fuktion.
>

Interesting. Would you mind running "lttng start" in verbose mode and
provide the output?
lttng -vvv start

> the same by
> $ lttng stop
> and
> $ lttng destroy
>
> but
> $ lttng create
> $ lttng enable-event -u -a
> $ lttng start
> $ lttng stop
> $ lttng destroy
> -> works
>
> how can i remove all installed lttng_modules,
> so that I can start again from the beginning?
>

lttng-modules does not define an "uninstall" make target. I guess
you'll have to delete the modules manually under
/lib/modules/$(uname -r)/extra
/lib/modules/$(uname -r)/extra/lib
/lib/modules/$(uname -r)/extra/probes

I'm wondering if it could be a conflict with your distribution's
lttng-modules-dkms package... Could you verify that it is not
installed?

> Thanks
> Klaus
> sorry, i am a linux beginner

No problem, we all were at some point :)

J=E9r=E9mie

>
>
>> Daniel U. Thibault
>> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
>> Countermeasures (SPC)
>> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critic=
al
>> Cyber Security (MCCS)
>> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence =
R&D
>> Canada - Valcartier (DRDC Valcartier)
>> 2459 route de la Bravoure
>> Qu=E9bec QC  G3J 1X5
>> CANADA
>> Vox : (418) 844-4000 x4245
>> Fax : (418) 844-4538
>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>> Gouvernement du Canada | Government of Canada
>> <http://www.valcartier.drdc-rddc.gc.ca/>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
