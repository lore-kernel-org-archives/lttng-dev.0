From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [documentation] Drawing: LTTng architecture in
 relation to the commandline / buffer options
Date: Mon, 26 May 2014 16:37:45 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359AE5D5__42933.5856963464$1401122345$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WoxuJ-0001hO-3j
 for lttng-dev@lists.lttng.org; Mon, 26 May 2014 12:37:56 -0400
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
Cc: Randy Wijnants <randy@tty32.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Mon, 26 May 2014 11:27:35 +0200
From: Randy Wijnants <randy@tty32.org>

> I've drawn the LTTng architecture in relation to the commandline / buffer=
 options.
> It would be nice if it would be used on the lttng website (if you find it=
 usefull ofcourse).
> I'm using this for a presentation at our company to explain more in-depth=
 lttng configuration details.
>
> Originally posted on IRC. As suggested by Compudj i've released it under =
CC license.
>
> Let me know what you think of it or if you have suggestions / improvements
>:)
> I can also provide SVG image, or push it to the repo?
>
> http://tty32.org/Logging%20configuration2.png
>
> Randy Wijnants.
----------------------------------------------------------------------
   SVG, please.  I may end up integrating it into the DocBook documentation.

   The dashed arrows running from userspace to liblttng-ust and the kernel =
to LTTng kernel module(s) don't make sense.  The remaining dashed arrows (a=
ll running from the session daemon) all represent control flow, which is no=
t what happens between userspace/kernel and liblttng-ust/LTTng-kernel-modul=
es.  You should use a different convention, such as dotted arrows.

   The enable-channel arrow should be accompanied by an enable-event arrow =
(same functionality, different resolution).

   You could also add a box for the lttng client, which talks to (controls)=
 the session daemon.

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
