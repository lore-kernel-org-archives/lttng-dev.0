From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Subject: Simple question about tracepoint defs
Date: Wed, 2 Jul 2014 02:02:25 -0400
Message-ID: <CAEEAEzX5h6FL6_cT5UJ+UyQa364jttLheQE6Br03fgZ9MRBW3Q__2971.12389603189$1404280994$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <babbusandy2006@gmail.com>) id 1X2Dck-0002bF-NF
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 02:02:33 -0400
Received: by mail-qg0-f44.google.com with SMTP id j107so4357310qga.17
 for <lttng-dev@lists.lttng.org>; Tue, 01 Jul 2014 23:02:25 -0700 (PDT)
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

Hi guys,

I have a simple question about tracepoint definitions.

Is it not possible to have two or more trace-point definitions in the
same header file?

Reading from the manual[1] as

"There can be an arbitrary number of tracepoint providers within an
application, but they must each have their own provider name. Duplicate
provider names are not allowed.",

I get the idea that it is not possible since each tracepoint provider
needs to have unique name, and therefore, should be in a different
header file.

Please confirm if this is the case.

It would be much better for me if it is possible to have multiple
trace-point definitions in the same header file.

[1] https://lttng.org/files/doc/man-pages/man3/lttng-ust.3.html

Thanks and regards,
Sandeep.
