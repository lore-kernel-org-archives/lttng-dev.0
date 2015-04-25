From: Jeff Layton <jlayton@poochiereds.net>
Subject: cds_lfht_count_nodes always returns -1 for before/after
	counts
Date: Sat, 25 Apr 2015 17:29:02 -0400
Message-ID: <20150425172902.08ca0cdc__8319.97193531624$1429997405$gmane$org@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vn0-f49.google.com ([209.85.216.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jlayton@poochiereds.net>) id 1Ym7dR-0007ZB-0O
 for lttng-dev@lists.lttng.org; Sat, 25 Apr 2015 17:29:17 -0400
Received: by vnbf190 with SMTP id f190so7626418vnb.1
 for <lttng-dev@lists.lttng.org>; Sat, 25 Apr 2015 14:29:07 -0700 (PDT)
Received: from tlielax.poochiereds.net
 ([2606:a000:1105:8e:3a60:77ff:fe93:a95d])
 by mx.google.com with ESMTPSA id at6sm12892401vdc.7.2015.04.25.14.29.06
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 25 Apr 2015 14:29:06 -0700 (PDT)
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

Hi, I have some code using the cds_lfht infrastructure, and recently
added a function to check to see if the table was empty using
cds_lfht_count_nodes. That function just does this:

        rcu_read_lock();
        cds_lfht_count_nodes(ht, &before, &count, &after);
        rcu_read_unlock();

What I've found though is that when the table is empty and I know that
there are no concurrent inserts going on, the before and after counters
are always set to -1 after this call.

Is that expected behavior? For the record, I'm using this package from
the Fedora 21 repos:

    userspace-rcu-0.8.1-5.fc21.x86_64

Thanks in advance!
-- 
Jeff Layton <jlayton@poochiereds.net>
