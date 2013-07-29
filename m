From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC] Dynamic instrumentation support in UST
Date: Mon, 29 Jul 2013 10:20:22 -0400
Message-ID: <CA+jJMxvi52qeC_Gcxg5+DrXfKfV7Nt2pvxaUtEwoopqZ3hZ-VQ__10127.0572668456$1375107684$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD1BE24A83@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V3oJI-0001T8-GO
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 10:20:34 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so4386908wgg.16
	for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2013 07:20:22 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD1BE24A83@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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

On Mon, Jul 29, 2013 at 9:49 AM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
> ----------------------------------------------------------------------
>> Date: Fri, 26 Jul 2013 23:40:33 +0800
>> From: Zifei Tong <soariez@gmail.com>
>>
>> Command Line Interface
>> ----------------------
>>
>> To enable a dynamic probe in a running process at given address, you can=
 use:
>>     lttng enable-event NAME -u --pid PID
>>         --probe (addr | symbol | symbol+offset)
>>                                Dynamic UST probe.
>>                                Addr and offset can be octal (0NNN...),
>>                                decimal (NNN...) or hexadecimal (0xNNN...)
>>
>> This will place a bare probe at certain address.
>
>    Unless I'm mistaken, currently lttng's 'enable-event -u ...' works onl=
y on already-running user-space processes.  It should be fairly easy to cha=
nge this so the event gets enabled for any new user-space process that regi=
sters itself with the session daemon while the session is in existence.  Th=
is would be possible only for instrumented applications, of course.  It sho=
uld also be possible to extend this to uninstrumented applications, as long=
 as the session daemon watches for new processes being launched.
>

lttng enable-event -u also works for processes that are not yet launched.

>    I would allow the above command line to specify a process name instead=
 of a process ID, in order to capture multi-threaded and multi-instance pro=
cesses.  When using process IDs, one also has to be careful of PID namespac=
es: for a member of the 'tracing' group, a PID issued from a local lttng co=
mmand (e.g. '$ lttng enable-event --pid ...') may need to be translated by =
the time it reaches the root lttng-sessiond.  Similar concerns exist with u=
ser namespaces.  The implications of namespaces are not peculiar to this ex=
tension of lttng, however: I would expect lttng to provide namespace-handli=
ng utility functions or to otherwise handle namespaces consistently through=
out its services.
>
>> Being only able to attach and instrument existing processes is sometimes=
 restricted. If we can have #15 [2] implemented, then we can extend the com=
mand to support dynamic instrumentation.
>>
>>    lttng trace -c COMMAND
>>        --probe (addr | symbol | symbol+offset)
>>        --function (addr | symbol | symbol+offset)
>>
>> This will execute given program and place probes at certain places.
>
>    The -c command option by itself may be insufficient in some cases.  Fo=
r instance, if the lttng command is issued from an su shell (e.g. '# lttng =
trace -c ...'), from a 'tracing' group member (e.g. '$ lttng trace -c ...')=
, or from some ordinary account (e.g. '$ sudo -H lttng trace -c ...'), the =
intent may be to specify which user account to run the COMMAND as.  An 'ltt=
ng trace' command would be problematic anyway since it may need to specify =
several events to enable, each assigned to a different channel and possibly=
 with a filter as well.  The overall command line could become very unwield=
y.  If enable-event is able to set up latent events (as described in my pre=
vious comment block), then 'lttng trace' is unnecessary: the user need only=
 set up his events, channels, etc., using --processname and then issue a pr=
oper 'sudo' command to launch the process (sudo has all the requisite optio=
ns to assign the process to the proper user account with the proper environ=
ment settings, etc.).
> ------------------------------
> Date: Fri, 26 Jul 2013 13:40:03 -0400
> From: Simon Marchi <simon.marchi@polymtl.ca>
>
>> What is the difference if I do
>>  --function foo
>>vs
>>  --probe foo
>> ?
>
>    If it follows the lttng kernel implementation, --function sets up a kr=
etprobe and --probe sets up a kprobe, so in user-space this should work sim=
ilarly: --probe sets up a function entry event while --function sets up a f=
unction entry AND a function return event.
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
