/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fakeftprintf.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bleplat <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/02/05 17:24:58 by bleplat           #+#    #+#             */
/*   Updated: 2019/02/05 18:57:02 by bleplat          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "tests.h"

int			ft_printf(const char *format, ...)
{
	return (printf(format, 42, 42));
}