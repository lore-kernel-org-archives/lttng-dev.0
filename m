From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [documentation] Drawing: LTTng trace session in
 relation to commandline options
Date: Tue, 27 May 2014 15:19:27 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359AE808__46624.4657444351$1401204058$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WpJAI-0001fq-77
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 11:19:51 -0400
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
Date: Tue, 27 May 2014 13:34:20 +0200
From: Randy Wijnants <dev@tty32.org>

> In addition to the LTTng architecture diagram, I've drawn a diagram that =
shows the relation between the command line options and how to configure a =
trace session.
> I hope it proves to be useful, if you have any suggestions let me know!
>
> Originally posted on IRC. As suggested by Compudj i've released it under =
CC license.
>
> http://tty32.org/Trace%20session.png
> http://tty32.org/Trace%20session.svg
>
> Randy Wijnants.
----------------------------------------------------------------------

   Neither the png nor svg versions line up correctly the text and coloured=
 boxes with each other.  This may be a local rendering issue.  At least the=
 svg version has a proper white background (my png renders with a very dark=
 grey background, making it very hard to make out some of the text).  Howev=
er, the svg version is unusable because none of the text is text: everythin=
g is svg:path with opaque d attributes (this may explain the alignment prob=
lems).

   Here are improved (more accurate) expressions for the various command sy=
ntaxes:

$ lttng create [NAME] [--ctrl-url URL --data-url URL | --output PATH | --se=
t-url URL | --no-output] [--snapshot]
   (the ctrl-url etc. options are in pre-emption order)

$ lttng enable-channel (-k | -u) [--session NAME] NAME[,NAME2,...] [--disca=
rd | --overwrite] [--subbuf-size SIZE] [--num-subbuf NUM] [--switch-timer U=
SEC] [--read-timer USEC] \
                                                                           =
                                     [--output (mmap | splice)] [--buffers-=
uid | --buffers-pid | --buffers-global] [--tracefile-size SIZE [--tracefile=
-count COUNT]]

$ lttng enable-event (-k | -u) [--session NAME] [--channel NAME] (--all [--=
tracepoint | --syscall] | \
                                            NAME[,NAME2,...] [--tracepoint =
[(--loglevel | --loglevel-only) LOGLEVEL] [--filter 'EXPRESSION'] | (--prob=
e | --function) (addr | symbol | symbol+offset)])

$ lttng add-context (-k | -u) [--session NAME] [--channel NAME] (--type TYP=
E)+

$ lttng list (-k | -u)
   (not the full syntax, but rather the syntax that will get just a list of=
 event names)

$ lttng add-context --help
   (the only one that doesn't change!)

   Change "Kernelspace specific" into "Kernel specific".

   Add footnotes:
* --session NAME defaults to the current session
* --channel NAME in the enable-event case defaults to 'channel0', but only =
if the domain is virgin
* --channel NAME in the add-context case defaults to all channels

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
