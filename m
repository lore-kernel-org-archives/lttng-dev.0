From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: Userspace RCU VS spin locks
Date: Wed, 30 Oct 2013 17:11:47 +0400
Message-ID: <CAO6Ho0ch2U2r5Ept2qFkOh1_Hxm6FcawsrzEmRQDEVi+KM5+tA__29514.4543787048$1383138774$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lolkaantimat@gmail.com>) id 1VbVYv-0006Y5-CI
	for lttng-dev@lists.lttng.org; Wed, 30 Oct 2013 09:11:58 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so2276349iec.28
	for <lttng-dev@lists.lttng.org>; Wed, 30 Oct 2013 06:11:47 -0700 (PDT)
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

Hi,

I'm very interested in RCU performance, especially applied to hash
tables (rculfhash in particular). Did any body compare performance of
QSBR or signal RCU VS scalable and non-scalable spin locks?

-- 
Cheers,
Evgeniy
