From: Jeff Layton <jlayton@poochiereds.net>
Subject: URCU and pthread mutex/cond variable hang
Date: Tue, 3 Mar 2015 15:40:14 -0500
Message-ID: <20150303154014.6a166f6e__14790.2805860669$1425415288$gmane$org@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/UPM1ZePaAxp0v9nkHZOS6Gp"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jlayton@poochiereds.net>) id 1YStc8-0007nx-IG
 for lttng-dev@lists.lttng.org; Tue, 03 Mar 2015 15:40:28 -0500
Received: by mail-qa0-f51.google.com with SMTP id k15so4013846qaq.10
 for <lttng-dev@lists.lttng.org>; Tue, 03 Mar 2015 12:40:19 -0800 (PST)
Received: from tlielax.poochiereds.net
 ([2606:a000:1105:196:3a60:77ff:fe93:a95d])
 by mx.google.com with ESMTPSA id v65sm1044630qgd.20.2015.03.03.12.40.18
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 03 Mar 2015 12:40:18 -0800 (PST)
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

--MP_/UPM1ZePaAxp0v9nkHZOS6Gp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've been using urcu to develop some userland code, and I've run into a
problem that I don't quite understand. If I register a thread and then
have that thread block on a pthread condition variable, then it seems
to cause synchronize_rcu in another thread to hang.

I've attached a testcase that demonstrates the problem. You have to
build it and link it against -lpthread and -lurcu-qsbr:

    $ gcc -Wall -o ./urcu_hang -lpthread -lurcu-qsbr urcu_hang.c

...it will run fine. If you comment out the rcu_thread_offline/online
calls though, it will hang.

Why? Is this expected behavior or a bug in urcu?

Thanks in advance!
-- 
Jeff Layton <jlayton@poochiereds.net>

--MP_/UPM1ZePaAxp0v9nkHZOS6Gp
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=urcu_hang.c

#include <urcu-qsbr.h>
#include <stdio.h>
#include <errno.h>
#include <pthread.h>
#include <stdbool.h>

static bool			done = false;
static pthread_mutex_t		mtx;
static pthread_cond_t		cond;

static void *
test_rcu(void __attribute__((unused)) *foo)
{
	rcu_register_thread();
	rcu_read_lock();
	rcu_read_unlock();
	synchronize_rcu();
	rcu_unregister_thread();

	pthread_mutex_lock(&mtx);
	done = true;
	pthread_cond_signal(&cond);
        pthread_mutex_unlock(&mtx);

	return NULL;
}

int
main(void)
{
	int 			ret;
	pthread_t		tid;
	pthread_attr_t		attr;

	rcu_register_thread();

	ret = pthread_mutex_init(&mtx, NULL);
	if (ret)
		return 1;

	pthread_cond_init(&cond, NULL);
	if (ret)
		return 1;

	ret = pthread_attr_init(&attr);
	if (ret)
		return 1;

	ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
	if (ret)
		return 1;

	ret = pthread_create(&tid, &attr, test_rcu, NULL);
	if (ret)
		return 1;

	rcu_quiescent_state();

	/*
	 * If you comment out the offline/online below, then the
	 * synchronize_rcu command in test_rcu will hang. Why?
	 */
//	rcu_thread_offline();
	pthread_mutex_lock(&mtx);
	while(!done)
		pthread_cond_wait(&cond, &mtx);
	pthread_mutex_unlock(&mtx);
//	rcu_thread_online();

	rcu_unregister_thread();

	return 0;
}

--MP_/UPM1ZePaAxp0v9nkHZOS6Gp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--MP_/UPM1ZePaAxp0v9nkHZOS6Gp--
