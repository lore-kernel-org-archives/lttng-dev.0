From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: RFC - Triggers in lttng-tools
Date: Thu, 11 Apr 2013 16:49:23 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D0DF8E__17453.2779412859$1365699042$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UQKhV-00013i-2D
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 12:50:17 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Based on http://lists.lttng.org/pipermail/lttng-dev/attachments/20130411/72=
56c589/attachment-0001.txt

> The main idea of triggers is for the user to be able to set an action on a
> session triggered by a certain event of the system. To illustrace the con=
cept,
> here is an example that we will actually propose.

[...] To illustrate the concept [...]

> Let say an application is being traced and on core dump, we would like to
> automatically snapshot the session and proceed to analysis later on.

Let's say an [...] and, on core dump, we [...]
or
Say an [...] and, on core dump, we [...]

> The idea would be to set a "trigger" named OnAnyCoreDump for the session.=
 Any
> coredump detected using /proc/sys/kernel/core_pattern will send a notific=
ation
> to the session daemon and trigger the user defined action.

[...] the user-defined action.

> First, a trigger command is needed and goes as followed.

[...] and goes as follows:

> For the example showed in the Motivation section, the <WHAT> is OnAnyCore=
Dump
> and the <ACTION> is to take a snapshot of the session where this trigger =
is
> set.

For the example shown in [...]

> In order to use the notify socket, the message protocol is detailed as
> followed.

[...] detailed as follows:

> Now to fire it up by being let say in a small program set in
> /proc/.../core_pattern.

Now to fire it up by being let's say in a small [...]

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
