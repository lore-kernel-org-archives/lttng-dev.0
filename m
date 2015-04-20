From: Duncan Sands <duncan.sands@deepbluecap.com>
Subject: DEBUG_RCU vs RCU_DEBUG
Date: Mon, 20 Apr 2015 10:07:38 +0200
Message-ID: <5534B3CA.6030306__3499.35972267321$1429546671$gmane$org@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <duncan.sands@deepbluecap.com>) id 1Yk6k6-0000Nw-Bp
 for lttng-dev@lists.lttng.org; Mon, 20 Apr 2015 04:07:47 -0400
Received: by wgyo15 with SMTP id o15so170048693wgy.2
 for <lttng-dev@lists.lttng.org>; Mon, 20 Apr 2015 01:07:40 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2e83:a840:19a5:da82:b784:d65e?
 ([2a01:e35:2e83:a840:19a5:da82:b784:d65e])
 by mx.google.com with ESMTPSA id o6sm14086480wiz.24.2015.04.20.01.07.39
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Apr 2015 01:07:39 -0700 (PDT)
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

I noticed that urcu-qsbr.h checks for RCU_DEBUG being defined while the rest of 
userspace-rcu (0.8.6) checks DEBUG_RCU.  Is this a mistake or a cunning plan?

Ciao, Duncan.
