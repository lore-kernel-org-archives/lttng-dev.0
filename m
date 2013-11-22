From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: make a trace_event in a modul (driver)
Date: Fri, 22 Nov 2013 14:01:15 -0500
Message-ID: <CA+jJMxt0zOzd897XEv7=-oEM-z7ZENHy385d5YK6hOp2gcEfeA__12464.8130652078$1385146938$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5932@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Vjvyj-00083i-9t
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 14:01:26 -0500
Received: by mail-qc0-f175.google.com with SMTP id e9so1002287qcy.6
	for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2013 11:01:15 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267A5932@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Nov 22, 2013 at 1:54 PM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>> how can I define a "tracing"group , so I no longer need the sudo command?
>
> $ sudo addgroup --system tracing
> $ sudo adduser username tracing
>

Thanks for providing the info Daniel, I read the original question
completely wrong!

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
>
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
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
