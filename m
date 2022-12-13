Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D458C4332F
	for <lttng-dev@archiver.kernel.org>; Tue, 13 Dec 2022 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1670941774;
	bh=ZoBhpBbIO92Ovh2PtyD3DOKfRqBrMIi3Nkpy5fAkm9w=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ADE/N2nCR41+clPGUxmcPFSNjvL+8KJtgRgYTZK2pUFn6LTpmtCEEydlP0S3ml5nZ
	 4lsqLtBBixYvIMqqtPFwHiGwrrc4zxplk4bYnR27Xix2ODBJYbjqTYGyw83e1+a1y2
	 McIbNQU9+G3gCTXMPPeFTcHFqyzUt4927HDXuTljWt5oYs9iF6teXATr8EihOP7Q/P
	 t9VW7O+UhTX00FhD4vrzhlh29UcEgq8SKL3dfN+oYqvCiVmvVUgadSPh2/SMHZQ1+K
	 nKOwsMsGKBcPn+8pZG3klPLlDmSo04ZfkRB/v2tYIpR+GRXovfcHBYIMaRB5h2Lk2V
	 RpaL/S4EbkHdg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NWgqd5Mq1zSk5;
	Tue, 13 Dec 2022 09:29:33 -0500 (EST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by lists.lttng.org (Postfix) with ESMTPS id 4NWRR42zgLzSjk
 for <lttng-dev@lists.lttng.org>; Tue, 13 Dec 2022 00:10:56 -0500 (EST)
Received: by mail-vs1-f48.google.com with SMTP id c184so13562354vsc.3
 for <lttng-dev@lists.lttng.org>; Mon, 12 Dec 2022 21:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wozsSMuXIUNpgQPRG6Ui/Bfwgn2aXFe2OHQosaUOINo=;
 b=0Dwic/B/xXD5I56NzJWwFBiR4bhkHM0Y6Itdz1nqgvyG2s3nQ0FqhrMJndzR89GiUH
 NWyhJTkb5egSYLjjaB+CtT/fLDeoGmTFZW9g5UJU8jwDVkIVxr2RT9vaiMXdxBOM/ati
 y/wItVe1qwXzuwTr1WnUjOgb9Ko3kKxqsuhb/hWZOCg8wTGM2TEeMT82maSYYheZxCSI
 OkzA581ROZWfIaPNaypjqdUNdU5v6yNtx12vWYag0mMod8lQRkuwu4+PAX8aMo3Nt8bb
 M0zqmNlUxmFJtheE678foOmWUKAm+5xbx4pbH6xz7FQCzQXtoltETizhEw7743nMRAh3
 t47Q==
X-Gm-Message-State: ANoB5plCWnHP2ZOSJzKq/gZIEYtoBlUrjRej3pudLIBG3v2f/jj2q0pn
 4tqrozcYLEOK4zHa/wVa07VjZDJAfjqj6cT1TC6BPWi8LCo=
X-Google-Smtp-Source: AA0mqf4SHz4NW1V1Clgsukqy2/fHlvmUVBbe4pEdfQcly18bnfiYT3v5UKo5qbTCAztm9fxw6qYponG/SG3z1Qp2gc8=
X-Received: by 2002:a67:d009:0:b0:3b1:4aad:9c47 with SMTP id
 r9-20020a67d009000000b003b14aad9c47mr9861148vsi.73.1670908195512; Mon, 12 Dec
 2022 21:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20221027055428.406908-1-alistair.francis@opensource.wdc.com>
In-Reply-To: <20221027055428.406908-1-alistair.francis@opensource.wdc.com>
Date: Tue, 13 Dec 2022 15:09:29 +1000
Message-ID: <CAKmqyKO2Kv72-c98_nC-Aprf8gFUJYrW1=kUkhf7B=cHMwmdtQ@mail.gmail.com>
To: Alistair Francis <alistair.francis@opensource.wdc.com>
X-Mailman-Approved-At: Tue, 13 Dec 2022 09:29:33 -0500
Subject: Re: [lttng-dev] [PATCH v2] Tests: select_poll_epoll: Add support
 for _time64
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Alistair Francis via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Alistair Francis <alistair23@gmail.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, Oct 27, 2022 at 3:54 PM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Add support for the  64-bit time_t syscalls SYS_ppoll_time64
> and SYS_pselect6_time64.
>
> These are the syscalls that exist 32-bit platforms since the 5.1 kernel.
> 32-bit platforms with a 64-bit time_t only have these and don't have the
> original syscalls (such as 32-bit RISC-V).
>
> Fixes: https://github.com/lttng/lttng-tools/pull/162
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Ping!

Alistair

> ---
> To keep the test_cases[] array clean I have implemented the functions
> for all builds, but the functions are a no-op if the syscall is missing.
>
> v2:
>  - Split out a seperate _time64 test
>
>  tests/regression/kernel/select_poll_epoll.cpp | 184 ++++++++++++++++++
>  1 file changed, 184 insertions(+)
>
> diff --git a/tests/regression/kernel/select_poll_epoll.cpp b/tests/regression/kernel/select_poll_epoll.cpp
> index c0b688217..dfaab52c8 100644
> --- a/tests/regression/kernel/select_poll_epoll.cpp
> +++ b/tests/regression/kernel/select_poll_epoll.cpp
> @@ -5,6 +5,7 @@
>   *
>   */
>
> +#include <errno.h>
>  #include <fcntl.h>
>  #include <limits.h>
>  #include <poll.h>
> @@ -48,10 +49,14 @@ int lttng_opt_quiet, lttng_opt_verbose, lttng_opt_mi;
>
>  static void run_working_cases(FILE *validation_output_file);
>  static void pselect_invalid_fd(FILE *validation_output_file);
> +static void pselect_time64_invalid_fd(FILE *validation_output_file);
>  static void test_ppoll_big(FILE *validation_output_file);
>  static void ppoll_fds_buffer_overflow(FILE *validation_output_file);
> +static void ppoll_time64_fds_buffer_overflow(FILE *validation_output_file);
>  static void pselect_invalid_pointer(FILE *validation_output_file);
> +static void pselect_time64_invalid_pointer(FILE *validation_output_file);
>  static void ppoll_fds_ulong_max(FILE *validation_output_file);
> +static void ppoll_time64_fds_ulong_max(FILE *validation_output_file);
>  static void epoll_pwait_invalid_pointer(FILE *validation_output_file);
>  static void epoll_pwait_int_max(FILE *validation_output_file);
>  static void ppoll_concurrent_write(FILE *validation_output_file);
> @@ -69,10 +74,14 @@ const struct test_case {
>         { .run = run_working_cases, .produces_validation_info = true, .timeout = -1 },
>         { .run = run_working_cases, .produces_validation_info = true, .timeout = 1 },
>         { .run = pselect_invalid_fd, .produces_validation_info = false, .timeout = 0 },
> +       { .run = pselect_time64_invalid_fd, .produces_validation_info = false, .timeout = 0 },
>         { .run = test_ppoll_big, .produces_validation_info = false, .timeout = 0 },
>         { .run = ppoll_fds_buffer_overflow, .produces_validation_info = false, .timeout = 0 },
> +       { .run = ppoll_time64_fds_buffer_overflow, .produces_validation_info = false, .timeout = 0 },
>         { .run = pselect_invalid_pointer, .produces_validation_info = false, .timeout = 0 },
> +       { .run = pselect_time64_invalid_pointer, .produces_validation_info = false, .timeout = 0 },
>         { .run = ppoll_fds_ulong_max, .produces_validation_info = false, .timeout = 0 },
> +       { .run = ppoll_time64_fds_ulong_max, .produces_validation_info = false, .timeout = 0 },
>         { .run = epoll_pwait_invalid_pointer, .produces_validation_info = true, .timeout = 0 },
>         { .run = epoll_pwait_int_max, .produces_validation_info = true, .timeout = 0 },
>         { .run = ppoll_concurrent_write, .produces_validation_info = false, .timeout = 0 },
> @@ -440,6 +449,44 @@ end:
>         return;
>  }
>
> +/*
> + * Ask for 100 FDs in a buffer for allocated for only 1 FD, should
> + * segfault (eventually with a "*** stack smashing detected ***" message).
> + * The event should contain an array of 100 FDs filled with garbage.
> + */
> +static
> +void ppoll_time64_fds_buffer_overflow(
> +               FILE *validation_output_file __attribute__((unused)))
> +{
> +#ifdef SYS_ppoll_time64
> +       struct pollfd ufds[NB_FD];
> +       char buf[BUF_SIZE];
> +       int ret;
> +
> +       ufds[0].fd = wait_fd;
> +       ufds[0].events = POLLIN|POLLPRI;
> +
> +       /*
> +        * As there is no timeout value, we don't convert to/from
> +        * 64/32-bit time_t.
> +        */
> +       ret = syscall(SYS_ppoll_time64, ufds, 100, NULL, NULL);
> +       /*
> +        * There is no fallback to SYS_ppoll, we expect SYS_ppoll_time64
> +        * to work and if it doesn't we fail.
> +        */
> +
> +       if (ret < 0) {
> +               PERROR("ppoll_time64");
> +       } else if (ret > 0) {
> +               ret = read(wait_fd, buf, BUF_SIZE);
> +               if (ret < 0) {
> +                       PERROR("[ppoll_time64] read");
> +               }
> +       }
> +#endif
> +}
> +
>  /*
>   * Ask for 100 FDs in a buffer for allocated for only 1 FD, should
>   * segfault (eventually with a "*** stack smashing detected ***" message).
> @@ -449,6 +496,7 @@ static
>  void ppoll_fds_buffer_overflow(
>                 FILE *validation_output_file __attribute__((unused)))
>  {
> +#ifdef SYS_ppoll
>         struct pollfd ufds[NB_FD];
>         char buf[BUF_SIZE];
>         int ret;
> @@ -466,6 +514,46 @@ void ppoll_fds_buffer_overflow(
>                         PERROR("[ppoll] read");
>                 }
>         }
> +#endif
> +}
> +
> +/*
> + * Ask for ULONG_MAX FDs in a buffer for allocated for only 1 FD, should
> + * cleanly fail with a "Invalid argument".
> + * The event should contain an empty array of FDs and overflow = 1.
> + */
> +static
> +void ppoll_time64_fds_ulong_max(FILE *validation_output_file __attribute__((unused)))
> +{
> +#ifdef SYS_ppoll_time64
> +       struct pollfd ufds[NB_FD];
> +       char buf[BUF_SIZE];
> +       int ret;
> +
> +       ufds[0].fd = wait_fd;
> +       ufds[0].events = POLLIN|POLLPRI;
> +
> +       /*
> +        * As there is no timeout value, we don't convert to/from
> +        * 64/32-bit time_t.
> +        */
> +       ret = syscall(SYS_ppoll_time64, ufds, ULONG_MAX, NULL, NULL);
> +       /*
> +        * There is no fallback to SYS_ppoll, we expect SYS_ppoll_time64
> +        * to work and if it doesn't we fail.
> +        */
> +
> +       if (ret < 0 && errno != ENOSYS) {
> +               /* Expected error. */
> +       } else if (errno == ENOSYS) {
> +               PERROR("[ppoll_time64] missing syscall");
> +       } else if (ret > 0) {
> +               ret = read(wait_fd, buf, BUF_SIZE);
> +               if (ret < 0) {
> +                       PERROR("[ppoll_time64] read");
> +               }
> +       }
> +#endif
>  }
>
>  /*
> @@ -476,6 +564,7 @@ void ppoll_fds_buffer_overflow(
>  static
>  void ppoll_fds_ulong_max(FILE *validation_output_file __attribute__((unused)))
>  {
> +#ifdef SYS_ppoll
>         struct pollfd ufds[NB_FD];
>         char buf[BUF_SIZE];
>         int ret;
> @@ -492,6 +581,59 @@ void ppoll_fds_ulong_max(FILE *validation_output_file __attribute__((unused)))
>                         PERROR("[ppoll] read");
>                 }
>         }
> +#endif
> +}
> +
> +/*
> + * Pass an invalid file descriptor to pselect6(). The syscall should return
> + * -EBADF. The recorded event should contain a "ret = -EBADF (-9)".
> + */
> +static
> +void pselect_time64_invalid_fd(FILE *validation_output_file __attribute__((unused)))
> +{
> +#ifdef SYS_pselect6_time64
> +       fd_set rfds;
> +       int ret;
> +       int fd;
> +       char buf[BUF_SIZE];
> +
> +       /*
> +        * Open a file, close it and use the closed FD in the pselect6 call.
> +        */
> +       fd = open("/dev/null", O_RDONLY);
> +       if (fd == -1) {
> +               PERROR("open");
> +               goto error;
> +       }
> +
> +       ret = close(fd);
> +       if (ret == -1) {
> +               PERROR("close");
> +               goto error;
> +       }
> +
> +       FD_ZERO(&rfds);
> +       FD_SET(fd, &rfds);
> +
> +       ret = syscall(SYS_pselect6_time64, fd + 1, &rfds, NULL, NULL, NULL, NULL);
> +       /*
> +        * There is no fallback to SYS_pselect6, we expect SYS_pselect6_time64
> +        * to work and if it doesn't we fail.
> +        */
> +
> +       if (ret == -1 && errno != ENOSYS) {
> +               /* Expected error. */
> +       } else if (errno == ENOSYS) {
> +               PERROR("[pselect_time64] missing syscall");
> +       } else if (ret) {
> +               ret = read(wait_fd, buf, BUF_SIZE);
> +               if (ret < 0) {
> +                       PERROR("[pselect_time64] read");
> +               }
> +       }
> +error:
> +       return;
> +#endif
>  }
>
>  /*
> @@ -501,6 +643,7 @@ void ppoll_fds_ulong_max(FILE *validation_output_file __attribute__((unused)))
>  static
>  void pselect_invalid_fd(FILE *validation_output_file __attribute__((unused)))
>  {
> +#ifdef SYS_pselect6
>         fd_set rfds;
>         int ret;
>         int fd;
> @@ -525,6 +668,7 @@ void pselect_invalid_fd(FILE *validation_output_file __attribute__((unused)))
>         FD_SET(fd, &rfds);
>
>         ret = syscall(SYS_pselect6, fd + 1, &rfds, NULL, NULL, NULL, NULL);
> +
>         if (ret == -1) {
>                 /* Expected error. */
>         } else if (ret) {
> @@ -535,6 +679,44 @@ void pselect_invalid_fd(FILE *validation_output_file __attribute__((unused)))
>         }
>  error:
>         return;
> +#endif
> +}
> +
> +/*
> + * Invalid pointer as writefds, should output a ppoll event
> + * with 0 FDs.
> + */
> +static
> +void pselect_time64_invalid_pointer(
> +               FILE *validation_output_file __attribute__((unused)))
> +{
> +#ifdef SYS_pselect6_time64
> +       fd_set rfds;
> +       int ret;
> +       char buf[BUF_SIZE];
> +       void *invalid = (void *) 0x42;
> +
> +       FD_ZERO(&rfds);
> +       FD_SET(wait_fd, &rfds);
> +
> +       ret = syscall(SYS_pselect6_time64, 1, &rfds, (fd_set *) invalid, NULL, NULL,
> +                       NULL);
> +       /*
> +        * There is no fallback to SYS_pselect6, we expect SYS_pselect6_time64
> +        * to work and if it doesn't we fail.
> +        */
> +
> +       if (ret == -1 && errno != ENOSYS) {
> +               /* Expected error. */
> +       } else if (errno == ENOSYS) {
> +               PERROR("[pselect_time64] missing syscall");
> +       } else if (ret) {
> +               ret = read(wait_fd, buf, BUF_SIZE);
> +               if (ret < 0) {
> +                       PERROR("[pselect_time64] read");
> +               }
> +       }
> +#endif
>  }
>
>  /*
> @@ -545,6 +727,7 @@ static
>  void pselect_invalid_pointer(
>                 FILE *validation_output_file __attribute__((unused)))
>  {
> +#ifdef SYS_pselect6
>         fd_set rfds;
>         int ret;
>         char buf[BUF_SIZE];
> @@ -563,6 +746,7 @@ void pselect_invalid_pointer(
>                         PERROR("[pselect] read");
>                 }
>         }
> +#endif
>  }
>
>  /*
> --
> 2.37.3
>
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
