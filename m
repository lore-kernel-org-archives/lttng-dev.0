From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: one sessiond for multiuser system
Date: Mon, 12 Aug 2013 18:47:39 -0400
Message-ID: <CA+jJMxu4fZr2M2xG_JF60BH67JqKJ-ELKw8=BcnfBZVYZbnPSg__44966.1827915863$1376347730$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD26661827@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxuWdmhzReR0Jy=y-tYFeGz3bod8FNUGBbY8mc0pdD_6LA@mail.gmail.com>
	<48CF5AC71E61DB46B70D0F388054EFFD2666421B@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f172.google.com ([74.125.82.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V90tu-0006fN-2X
	for lttng-dev@lists.lttng.org; Mon, 12 Aug 2013 18:47:52 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so5997165wes.17
	for <lttng-dev@lists.lttng.org>; Mon, 12 Aug 2013 15:47:40 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2666421B@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

On Mon, Aug 12, 2013 at 4:23 PM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
> -----Message d'origine-----
> Envoy=E9 : 12 ao=FBt 2013 16:11
>
> On Mon, Aug 12, 2013 at 9:23 AM, Thibault, Daniel <Daniel.Thibault@drdc-r=
ddc.gc.ca> wrote:
>> ----------------------------------------------------------------------
>>    Actually, a non-root user can also access the root daemon if he has s=
udo privileges.
>>
>>    The root daemon will see the various user-space events, but it will
>> *not* list the user sessions: the various lttng-sessiond daemons do
>> not talk to each other.  (This may become possible with a later
>> version of lttng)
>>
>>    To funnel all tracing through the root daemon, make sure any user ltt=
ng-sessiond daemons are killed and only the root lttng-sessiond daemon is r=
unning, then either make your users members of the 'tracing' group, or syst=
ematically use 'sudo lttng ...' or 'sudo -H lttng ...' from the user shells=
.  The first form will put the trace outputs in each user's ~/lttng-traces,=
 the second form will combine all trace outputs in /root/lttng-traces.  You=
 may need to chmod the resulting folders and files if you want to later acc=
ess them as non-root.
>
> Keep in mind that in this scenario, setting up your traces as root (using=
 sudo) will still not let users that are not part of the 'tracing' group tr=
ace their applications as no interactions with the session daemon are allow=
ed; that includes application registration.
>
> Getting around that would require that your users also launch the applica=
tions themselves as root (using sudo) which is an unnecessary security risk.
>
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> -----Fin du message d'origine-----
>
>    I'm not sure I understand what you're getting at when you say "setting=
 up your traces as root (using sudo) will still not let users that are not =
part of the 'tracing' group trace their applications as no interactions wit=
h the session daemon are allowed; that includes application registration." =
 Users that are not part of the 'tracing' group need take no special action=
 to get their apps traced: the root session daemon sees all user-spaces.

You're right. There seems to be an unrelated problem on my system. So,
to clarify:

- A root session daemon can only be controlled (e.g. create and modify
sessions) by root and members of the tracing group.
- Applications do not need to run as a member of the tracing group to be tr=
aced.

J=E9r=E9mie

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



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
