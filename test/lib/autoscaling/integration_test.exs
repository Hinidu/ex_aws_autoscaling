defmodule ExAws.AutoScaling.IntegrationTest do
  use ExUnit.Case, async: true

  test "#describe_auto_scaling_groups" do
    assert {:ok, %{body: body}} =
      ExAws.AutoScaling.describe_auto_scaling_groups |> ExAws.request
    assert body |> String.contains?("DescribeAutoScalingGroupsResponse")
  end
end
