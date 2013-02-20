From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Function of lttng create --disable-consumer?
Date: Wed, 20 Feb 2013 21:15:06 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD01C538__24417.0276717798$1361394987$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1U8H0n-0003aH-5C
	for lttng-dev@lists.lttng.org; Wed, 20 Feb 2013 16:15:33 -0500
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

Back on Wed Oct 3 14:27:07 EDT 2012, David Goulet wrote, in response to Ber=
nd Hufmann:

> >   * I'm not sure what is the purpose of the options --no-consumer or
> >     --disable-consumer. Could you please explain the use cases for using
> >     --no-consumer or --disable-consumer? =

>
> This basically disables the consumer for a tracing session. It's not very
> useful for now but for upcoming snapshots and live tracing, it will make
> way more sense! :).

In the create.c command code, the --disable-consumer option is checked in o=
nly one place, and serves to call disable_consumer after the -C/-D option p=
air has called enable_consumer to commit its configuration.  However, exper=
imentation reveals something odd:

$ sudo -H lttng create sessiona

By itself, this does not launch the consumer daemon (I'm keeping an eye on =
the System Monitor window's list of processes, where lttng-consumerd normal=
ly appears).  Once I later do:

$ sudo -H lttng enable-event sched_switch -k

The consumer launches at that point.  There is no option in enable-event to=
 prevent this.  If I instead do:

$ sudo -H lttng create sessiona --disable-consumer
$ sudo -H lttng enable-event sched_switch -k

Precisely the same thing happens.  Likewise for 'lttng create sessiona -U n=
et://131.131.131.131' with or without the --disable-consumer switch.  But i=
f I instead do:

$ sudo -H lttng create sessiona --disable-consumer -C net://131.131.131.131=
 -D net://131.131.131.131
$ sudo -H lttng enable-event sched_switch -k

(Where the net: target has lttng-relayd running) The consumer does *not* la=
unch.  Not even after I do:

$ sudo -H lttng enable-consumer

Starting the trace does not launch the consumer either and, not surprisingl=
y, the trace does not get written anywhere.  And all this without any error=
 or warning messages. 'lttng list' looks normal, too.

Is this a bug or am I missing something?

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
