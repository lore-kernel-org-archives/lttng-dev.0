From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@ericsson.com>
Subject: Re: How to check is tracepoint is currently enabled
	(UST)
Date: Wed, 25 Jun 2014 10:49:00 -0400
Message-ID: <53AAE15C.3040100__47963.2281502292$1403707805$gmane$org@ericsson.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359C62DE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1WzoVW-0000EJ-Td
 for lttng-dev@lists.lttng.org; Wed, 25 Jun 2014 10:49:12 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD359C62DE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

You can also list all ust events available for tracing via the command "ltt=
ng list -u". =


Make sure that the application you want to trace is running. =


On 06/25/2014 10:40 AM, Thibault, Daniel wrote:
> ----------------------------------------------------------------------
> Date: Sun, 22 Jun 2014 19:27:31 +0400
> From: Dmitri Shubin <sbn@tbricks.com>
> =

>> In dtrace it's possible to check if some probe is currently enabled or n=
ot (to avoid argument preparation for disabled probes).
>> But I'm unable to find similar feature in lttng-ust (at least it's not m=
entioned in lttng-ust man page).
>>
>> Am I missed it or it's not implemented on purpose?
> =

>    Use the list command.  A command such as 'lttng list <session_name>' w=
ill list the known events and their enabled/disabled status.  You can filte=
r the command's output by specifying a domain (--userspace) and/or a channe=
l (--channel <channel_name>).  For example:
> =

> (begin example)
> $ lttng create some_session
> Session some_session created.
> Traces will be written in /home/username/lttng-traces/ some_session-20140=
625-102709
> $ lttng enable-event -u some_event
> UST event some_event created in channel channel0
> $ lttng list some_session -u --channel channel0
> Tracing session some_session: [inactive]
>     Trace path: /home/username/lttng-traces/ some_session-20140625-102709
> =

> =3D=3D=3D Domain: UST global =3D=3D=3D
> =

> Buffer type: per UID
> =

> - channel0: [enabled]
> =

>     Attributes:
>       overwrite mode: 0
>       subbuffers size: 131072
>       number of subbufers: 4
>       switch time interval: 0
>       read time interval: 0
>       output: mmap()
> =

>     Events:
>       some_event (type: tracepoint) [enabled]
> (end example)
> =

>    You can take a look at /usr/src/lttng-tools/src/bin/lttng/commands/lis=
t.c to see how the information is obtained.
> =

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Ce=
ntre
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
