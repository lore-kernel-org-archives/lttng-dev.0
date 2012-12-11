From: "=?utf-8?B?enM=?=" <84500316@qq.com>
Subject: 'call_rcu' unstable?
Date: Tue, 11 Dec 2012 22:20:13 +0800
Message-ID: <tencent_3FFFB50C2209B0C914907B07__5686.13927248425$1355235768$gmane$org@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpbg13.qq.com ([183.60.61.234])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <84500316@qq.com>) id 1TiQiD-0007a8-6J
	for lttng-dev@lists.lttng.org; Tue, 11 Dec 2012 09:21:34 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?bHR0bmctZGV2?= <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi list,

I found a big problem in my product, that use urcu 0.7.5. My program cost too mutch CPU in the funtion 'update_counter_and_wait:uruc.c:247', and I use gdb to see to *wait_loops*, it says -167777734. The CPU usage grows up from 1% to 100% in one day!


Here is the sample code to show how I use urcu library:

#include <urcu.h>

thread ()
{
rcu_register_thread();

for (;;) {
rcu_read_lock();
xxx
rcu_read_unlock();
}
}

main()
{
rcu_init();
  pthread_create(, , , , thread);

rcu_register_thread();
for (;;)
{
 if (xxx)
   call_rcu();
}

}
