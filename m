From: Eugene Ivanov <Eugene.Ivanov@orc-group.com>
Subject: cds_lfht_resize() and QSBR
Date: Mon, 27 Jul 2015 19:03:32 +0300
Message-ID: <55B65654.7030503__45122.7581398145$1438013076$gmane$org@orc-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx02.orcsoftware.com ([89.202.167.90]
 helo=ungol.ad.orcsoftware.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Eugene.Ivanov@orc-group.com>) id 1ZJksS-0000Cx-3M
 for lttng-dev@lists.lttng.org; Mon, 27 Jul 2015 12:03:45 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

According documentation "cds_lfht_resize should *not* be called from a
RCU read-side critical section", can I use this function with QSBR,
where almost everything is read-side CS? And cds_lfht_destroy()?

--
Eugene Ivanov


________________________________

This e-mail is confidential and may contain legally privileged information. It is intended only for the addressees. If you have received this e-mail in error, kindly notify us immediately by telephone or e-mail and delete the message from your system.
