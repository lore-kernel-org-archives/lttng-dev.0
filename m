From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: LTTng 2.5 save/load feature feedback
Date: Fri, 30 May 2014 17:16:55 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359AEEB6__33027.2734318443$1401470291$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WqQQQ-0002yr-Hk
 for lttng-dev@lists.lttng.org; Fri, 30 May 2014 13:17:08 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Fri, 30 May 2014 11:54:02 -0400
From: Julien Desfossez <jdesfossez@efficios.com>

> [...]
> Everything went fine (except for the already known bug of all the context=
s information not recorded in the XML file). As expected, the XML file was =
saved in
> ~/.lttng/sessions/lttngtop.lttng.
>
> What surprised me was to see this message when later on I started manuall=
y a lttng-sessiond as my user (after it had been killed) :
> Error: Failed to load session lttngtop: Tracing the kernel requires a roo=
t lttng-sessiond daemon, as well as "tracing" group membership or root user=
 ID for the lttng client.
> Error: Session load failed: Tracing the kernel requires a root lttng-sess=
iond daemon, as well as "tracing" group membership or root user ID for the =
lttng client.
>
> I did not expect that the saved sessions would try to auto load when the =
sessiond was starting. =

> I did not try with system-wide sessions, but that's the same, I don't rea=
lly expect that all sessions to be automatically loaded on startup.
> I think a sysadmin (or even the lttng installer) could make some tracing =
profiles available to the users in there so that they can use them when nee=
ded.
> Also, the fact that a user sessiond tries to load a session that clearly =
requires a root sessiond is kind of confusing.
>
> I can see the value of having auto-loaded sessions, but I think it should=
 be configurable, either directly in the XML (just like to "started" option=
) or with sessions saved in a different path (for example ~/.lttng/auto-ses=
sions/).
> Also, I think that our users are never really spawning manually a session=
d, so maybe the "lttng load -a" is more suited for the auto-loading process.
>
> So we could maybe add an option to the "lttng save" command that allows t=
he user to specify if the session should be auto-loaded.
> With that in mind, should the users part of the tracing group allowed to =
save auto-loading kernel sessions in the system-wide tracing directory, or =
will they have to ask an admin to manually install their profile ?
>
> I apologize for not providing this kind of feedback when the RFC was post=
ed here, I just realized these usability details when I actually experiment=
ed the feature.
>
> Julien

   This is a direct consequence of the session concept being user-oriented:=
 the sessions belong to users.  But users that belong to the tracing group =
can run lttng in two ways, as you've run into: they can run a private sessi=
on daemon, or talk to the root daemon.

   I would suggest adding a property to the session file that would identif=
y the target session daemon.  The session daemons would, upon trying to loa=
d the sessions, silently reject the inappropriate ones.  The only problem w=
ith this approach is that sessions targeting either daemon could not bear t=
he same names.

   Alternately, sessions could be stored in two sub-directories of ~/.lttng=
/sessions/ depending on the target daemon: say ~/.lttng/sessions/root/ and =
~/.lttng/sessions/user/.  This would allow homonymous sessions.

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
