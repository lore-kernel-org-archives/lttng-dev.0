From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: How to check is tracepoint is currently enabled
 (UST)
Date: Wed, 25 Jun 2014 14:40:15 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359C62DE__11117.2697427266$1403707295$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WzoN3-000085-Qr
 for lttng-dev@lists.lttng.org; Wed, 25 Jun 2014 10:40:27 -0400
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
Date: Sun, 22 Jun 2014 19:27:31 +0400
From: Dmitri Shubin <sbn@tbricks.com>

> In dtrace it's possible to check if some probe is currently enabled or no=
t (to avoid argument preparation for disabled probes).
> But I'm unable to find similar feature in lttng-ust (at least it's not me=
ntioned in lttng-ust man page).
>
> Am I missed it or it's not implemented on purpose?

   Use the list command.  A command such as 'lttng list <session_name>' wil=
l list the known events and their enabled/disabled status.  You can filter =
the command's output by specifying a domain (--userspace) and/or a channel =
(--channel <channel_name>).  For example:

(begin example)
$ lttng create some_session
Session some_session created.
Traces will be written in /home/username/lttng-traces/ some_session-2014062=
5-102709
$ lttng enable-event -u some_event
UST event some_event created in channel channel0
$ lttng list some_session -u --channel channel0
Tracing session some_session: [inactive]
    Trace path: /home/username/lttng-traces/ some_session-20140625-102709

=3D=3D=3D Domain: UST global =3D=3D=3D

Buffer type: per UID

- channel0: [enabled]

    Attributes:
      overwrite mode: 0
      subbuffers size: 131072
      number of subbufers: 4
      switch time interval: 0
      read time interval: 0
      output: mmap()

    Events:
      some_event (type: tracepoint) [enabled]
(end example)

   You can take a look at /usr/src/lttng-tools/src/bin/lttng/commands/list.=
c to see how the information is obtained.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
