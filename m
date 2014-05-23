From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-ust under the hood
Date: Fri, 23 May 2014 15:11:02 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359ADFFC__44615.4319834479$1400857925$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Wnr7k-0002Yu-Vh
 for lttng-dev@lists.lttng.org; Fri, 23 May 2014 11:11:14 -0400
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
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Thu, 22 May 2014 18:21:29 +0200
From: Gerlando Falauto <gerlando.falauto@keymile.com>

> I'm still struggling to figure out why, depending on how I compile and li=
nk my application, I can get either custom tracepoint providers
> OR tracef() to work, but not both at the same time.
>
> Is there any documentation explaining how lttng-ust is roughly supposed t=
o work?
> (i.e. linking trickeries, libraries needed in LD_PRELOAD, _LGPL_SOURCE, t=
racepoints, probes and so on...)
>
> Gerlando

   It's all a matter of choice.  Tracepoint providers can be in the app (st=
atically linked in) or dynamically linked to it.  In the latter case, the l=
inking can be mandatory (so the app will fail to launch if it cannot find t=
he tracepoint provider .so) or optional.  With optional linking, failure to=
 find the .so means the app isn't traceable but otherwise runs normally.  L=
D_PRELOAD is generally used to provide the app with the tracepoint provider=
 .so when tracing is desired.

   Extensive documentation (in PDF) is currently undergoing editorial revie=
w, and the plan is to move said documentation to DocBook format so it can b=
e included in the LTTng distribution.

  Since tracef() depends on liblttng-ust just like ordinary UST, I'm not su=
re which problem you're running into.  Could you give us a simplified makef=
ile that showcases the issue?

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
