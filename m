From: changz <zheng.chang@emc.com>
Subject: Re: Deaklock in liblttng-ust
Date: Tue, 18 Sep 2012 11:57:34 +0800
Message-ID: <5057F12E.2090209__14971.8032371768$1347940755$gmane$org@emc.com>
References: <6539770C71C3814BB0BFC2DBEBD1050801062B20@CORPUSMX30B.corp.emc.com>
	<20120913113739.GA27777@Krystal> <5052AC26.5050904@emc.com>
	<20120917133324.GC4256@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1539278952=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Zheng.Chang@emc.com>) id 1TDoxP-0007yp-Bx
	for lttng-dev@lists.lttng.org; Mon, 17 Sep 2012 23:58:43 -0400
In-Reply-To: <20120917133324.GC4256@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1539278952==
Content-Type: multipart/alternative;
 boundary="------------030806020303090607030408"

This is a multi-part message in MIME format.
--------------030806020303090607030408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/2012 21:33 PM, Mathieu Desnoyers wrote:
> * changz (zheng.chang@emc.com) wrote:
>> ......
>>
>> The child process calls _fini when it calls API exit. It gets hung and
>> meanwhile the parent is waiting for its termination.
>> I think the whole life-cycle of the process should be considered. The
>> parent's waiting in critical region is dangerous.
>> Is it possible to refine the critical region with smaller fineness?
>>
>> What do you think?
> Hrm, yes you're right. I'm looking into it.
>
> The main issue is that get_wait_shm() bypass the fork() wrapper (with
> lttng_ust_nest_count), which is responsible for holding the UST mutex
> across fork(). Therefore, when exiting the context of the child process,
> we execute the destructor, which try to grab the UST mutex, which might
> be in pretty much any state.
>
> Given that we don't want this process to try to register to
> lttng-sessiond (because this is internal to lttng-ust), we might want to
> let it skip the destructor execution. This would actually be the easiest
> way out.
>
> Does the follow patch fix the issue for you ?
>
> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> index be64acd..596fd7d 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -616,9 +616,9 @@ int get_wait_shm(struct sock_info *sock_info, size_t mmap_size)
>   			ret = ftruncate(wait_shm_fd, mmap_size);
>   			if (ret) {
>   				PERROR("ftruncate");
> -				exit(EXIT_FAILURE);
> +				_exit(EXIT_FAILURE);
>   			}
> -			exit(EXIT_SUCCESS);
> +			_exit(EXIT_SUCCESS);
>   		}
>   		/*
>   		 * For local shm, we need to have rw access to accept
Yes, it works.
Just a reminder, here arefour callings of exit in child's path in my git 
repository.

Thanks & BR
-Zheng




--------------030806020303090607030408
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 9/17/2012 21:33 PM, Mathieu
      Desnoyers wrote:<br>
    </div>
    <blockquote cite="mid:20120917133324.GC4256@Krystal" type="cite">
      <pre wrap="">* changz (<a class="moz-txt-link-abbreviated" href="mailto:zheng.chang@emc.com">zheng.chang@emc.com</a>) wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">......

The child process calls _fini when it calls API exit. It gets hung and  
meanwhile the parent is waiting for its termination.
I think the whole life-cycle of the process should be considered. The  
parent's waiting in critical region is dangerous.
Is it possible to refine the critical region with smaller fineness?

What do you think?
</pre>
      </blockquote>
      <pre wrap="">
Hrm, yes you're right. I'm looking into it.

The main issue is that get_wait_shm() bypass the fork() wrapper (with
lttng_ust_nest_count), which is responsible for holding the UST mutex
across fork(). Therefore, when exiting the context of the child process,
we execute the destructor, which try to grab the UST mutex, which might
be in pretty much any state.

Given that we don't want this process to try to register to
lttng-sessiond (because this is internal to lttng-ust), we might want to
let it skip the destructor execution. This would actually be the easiest
way out.

Does the follow patch fix the issue for you ?

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index be64acd..596fd7d 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -616,9 +616,9 @@ int get_wait_shm(struct sock_info *sock_info, size_t mmap_size)
 			ret = ftruncate(wait_shm_fd, mmap_size);
 			if (ret) {
 				PERROR("ftruncate");
-				exit(EXIT_FAILURE);
+				_exit(EXIT_FAILURE);
 			}
-			exit(EXIT_SUCCESS);
+			_exit(EXIT_SUCCESS);
 		}
 		/*
 		 * For local shm, we need to have rw access to accept
</pre>
    </blockquote>
    Yes, it works. <br>
    Just a reminder, here are<big> four</big> callings of exit in
    child's path in my git repository.<br>
    <br>
    Thanks &amp; BR<br>
    -Zheng<br>
    <br>
    <blockquote cite="mid:20120917133324.GC4256@Krystal" type="cite">
      <pre wrap="">
</pre>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------030806020303090607030408--


--===============1539278952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1539278952==--
