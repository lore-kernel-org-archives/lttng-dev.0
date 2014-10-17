From: "Boisvert, Sebastien" <boisvert@anl.gov>
Subject: Writing .tp files for lttng-gen-tp
Date: Fri, 17 Oct 2014 21:39:21 +0000
Message-ID: <E949C1E351B4914B87A26A5F96E06A9286ABF8__19058.7213532583$1413582016$gmane$org@PAYTON.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailrelay.anl.gov ([130.202.101.22])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <boisvert@anl.gov>) id 1XfFF9-00015C-O7
 for lttng-dev@lists.lttng.org; Fri, 17 Oct 2014 17:39:30 -0400
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTP id 173107CC3B2
 for <lttng-dev@lists.lttng.org>; Fri, 17 Oct 2014 16:39:22 -0500 (CDT)
Content-Language: en-US
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

Hi,

I wrote a big .tp file to define numerous tracepoints that only differ in t=
he event name.
They all take the same arguments and they all dump the same fields.


.tp file: https://github.com/sebhtml/biosal/blob/master/engine/thorium/trac=
epoints/lttng/message.tp


Is there a more compact way of doing that ?


                S=E9bastien
