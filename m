From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Unable to make lttng run for multiple instances
	in	parallel
Date: Mon, 23 Mar 2015 13:49:54 +0000 (UTC)
Message-ID: <831190398.75671.1427118594032.JavaMail.zimbra__25066.1079226576$1427118652$gmane$org@efficios.com>
References: <CAL1ZhON-ZwP_C6VvzPv9Jj530fRRVdevuCk+zAq9zVM-enApiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Ya2jt-0007l6-Nc
 for lttng-dev@lists.lttng.org; Mon, 23 Mar 2015 09:49:58 -0400
In-Reply-To: <CAL1ZhON-ZwP_C6VvzPv9Jj530fRRVdevuCk+zAq9zVM-enApiA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Chidhu R <chid1989@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message ----- 

> Hello,

> When I try to execute the following code, I always run into errors. Can
> someone help me.

> Code:

> int lttng_init() {
> int err;
> int l_fd = -1;

> if(0 != system("mkdir /tmp/mk_lttng")) {
> printf("Directory exists\n");
> }

> setenv("LTTNG_HOME", "/tmp/mk_lttng", 1);
> fprintf(stderr, "LTTNG_HOME is %s\n",getenv("LTTNG_HOME"));

> l_fd = open("/tmp/lttng_test.lck", O_CREAT | O_WRONLY | O_EXCL, 0644);
> err = errno;

> if(l_fd != -1) {
> fprintf(stderr, "Creating lock file l_fd = %d\n", l_fd);
> if(0 != system("lttng destroy -a")) {
> return -1;
> }

> if(0 != system("lttng create")) {
> return -1;
> }

> if(0 != system("lttng enable-event -u -a")) {
> return -1;
> }

> if(0 != system("lttng start")) {
> return -1;
> }

> }
> else {
> fprintf(stderr, "Unable to get lock err = %d\n",err);
> // Someone has already created a session. We just dump into their buffer
> }
> }

> int main() {
> if( -1 == lttng_init())
> assert(0);
> }

> When I compile and run the above code, I am getting these errors.

> cycl01:~/hello-tp% ./hello
> mkdir: cannot create directory `/tmp/mk_lttng': File exists
> Directory exists
> LTTNG_HOME is /tmp/mk_lttng
> Creating lock file l_fd = 4
> Spawning a session daemon
> I/O warning : failed to load external entity
> "/usr/share/xml/lttng/session.xsd"
> XML Error: Failed to locate the main schema resource at
> '/usr/share/xml/lttng/session.xsd'.
> Error: XSD parsing failed
> Error: Session load failed: Invalid session configuration
> No session found, nothing to do.
> PERROR - 09:20:36.889067 [7142/7150]: bind inet: Address already in use (in
> lttcomm_bind_inet_sock() at inet.c:109)
> Warning: Another session daemon is using this JUL port. JUL support will be
> deactivated to prevent interfering with the tracing.

> I am trying to run multiple of these programs in parallel . So I am trying to
> incorporate a locking mechanism so that only one instance succeeds and
> creates the session, and other instances just dump into the existing
> session.

You might wait to try starting the lttng-sessiond daemon explicitly 
before running your program. This might help a bit. 

Thanks, 

Mathieu 

> Thanks
> Chid

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
