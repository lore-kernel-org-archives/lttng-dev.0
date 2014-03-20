From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng-health-check
Date: Thu, 20 Mar 2014 15:57:11 -0400
Message-ID: <CA+jJMxsC51zZQefga+QKn90PpsSk0f81Ya=Ugs5b3_f-9OkgKw__28312.6289876693$1395345536$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD3598FA27@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WQj5Y-0003C6-Q6
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 15:57:19 -0400
Received: by mail-qg0-f47.google.com with SMTP id 63so4069277qgz.6
	for <lttng-dev@lists.lttng.org>; Thu, 20 Mar 2014 12:57:11 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD3598FA27@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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

On Thu, Mar 20, 2014 at 2:27 PM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
> LTTNG_HEALTH_APP_MANAGE:
> The lttng-health-check function will report the health of the application=
 command socket manager subsystem.  This session daemon thread (thread_mana=
ge_apps) watches the application command sockets; their closure indicates a=
pplication shutdown (more accurately, shutdown of the application's tracepo=
int provider) and triggers unregistration.
>
> Would it be correct to say that if this component malfunctions, closure o=
f application trace files (if tracing in per-process ID mode) will be delay=
ed until the session is destroyed, but that there won't be any other truly =
deleterious consequences?  It seems unlikely any events will be lost (the c=
onsumer will commit the buffer contents normally), and this thread failure =
would not hamper tracing of other applications nor client-controlled enabli=
ng and disabling of events.  The lttng list of event sources would include =
ghosts (dead-and-gone apps).  Could lttng hang if the client tried to toggl=
e the enabling of events published by the ghosts?
>

It depends on where the "manage apps" thread hangs/dies. Both
scenarios are a possibility. The outcome depends largely on whether or
not the thread was holding a lock at that time.

> I guess my point is that, of all the possible health failures, this seems=
 the least catastrophic one.
>

One important thing to understand is that the health check is not an
error recovery mechanism; it is only meant as a tool to detect
unexpected internal errors from which we can only recover by
restarting.

Regards,
J=E9r=E9mie

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
