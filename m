From: "=?iso-8859-1?Q?David_Lindstr=F6m?=" <david.lindstrom@percepio.se>
Subject: Quick question about discarded events
Date: Mon, 4 Nov 2013 14:32:02 +0100
Message-ID: <0933C0CB348B439382FA527A480D7695__36678.1984958381$1383571987$gmane$org@DVDMANDT5>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.lindstrom@percepio.se>) id 1VdKGJ-0006i2-5r
	for lttng-dev@lists.lttng.org; Mon, 04 Nov 2013 08:32:13 -0500
Received: by mail-lb0-f176.google.com with SMTP id z5so5326435lbh.21
	for <lttng-dev@lists.lttng.org>; Mon, 04 Nov 2013 05:32:05 -0800 (PST)
Received: from DVDMANDT5 (h185n9.malarenergi.ias.bredband.telia.com.
	[90.224.212.185])
	by mx.google.com with ESMTPSA id oc1sm16586855lbb.3.2013.11.04.05.32.03
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 04 Nov 2013 05:32:04 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi everyone,

If I encounter a trace where a packet contains the events_discarded field =

with a non-zero value, I want to warn/notify the user. Were the events =

discarded before the timestamp_begin of the packet, after timestamp_end or =

in between? I basically want to plot some symbol on my timeline =

approximately where the user can expect bad/missing data.

Mvh
David Lindstr=F6m =
