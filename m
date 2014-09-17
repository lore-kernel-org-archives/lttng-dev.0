From: Elie Abi Saad <abisaad.elie@gmail.com>
Subject: Live reading without using disk
Date: Wed, 17 Sep 2014 12:50:33 +0200
Message-ID: <CAD+1jo_H23O5HiJ9n6VWFDfe7xMTN+26j_0PqXkZjXSYPRO7+g__28201.8140111633$1410951095$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abisaad.elie@gmail.com>) id 1XUCop-0000uq-9l
 for lttng-dev@lists.lttng.org; Wed, 17 Sep 2014 06:50:42 -0400
Received: by mail-qg0-f52.google.com with SMTP id i50so1591130qgf.39
 for <lttng-dev@lists.lttng.org>; Wed, 17 Sep 2014 03:50:33 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I want to make statistics on tracepoints at runtime and would like to know if
there is a way to do live reading on traces without flushing them on disk.

Live mode seems good to me, but do continuously write traces on disk, and
snapshot mode sounds perfect with the ring buffer mechanism, but we still need
to record snapshots to read traces.

Any suggestions?

Cheers,

-- 
Elie Abi Saad
